import 'dart:io';

import 'package:cli_dialog/cli_dialog.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

import 'package:get_cli/commands/impl/args_mixin.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/json_serialize/model_generator.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/exception_handler/exceptions/cli_exception.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/functions/find_file/find_folder_by_directory.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/get_provider.dart';

class GenerateModelCommand extends Command with ArgsMixin {
  @override
  Future<void> execute() async {
    String name = p.basenameWithoutExtension(withArgument).pascalCase;
    if (withArgument.isEmpty) {
      final dialog = CLI_Dialog(questions: [
        [LocaleKeys.ask_model_name.tr, 'name']
      ]);
      String result = dialog.ask()['name'];
      name = result.pascalCase;
    }

    FileModel _fileModel;
    final classGenerator = ModelGenerator(name);

    if (findFolderByName('models') != null) {
      _fileModel = Structure.model(name, 'model', onCommand != '',
          on: onCommand != '' ? onCommand : 'models', folderName: 'models');
    } else {
      _fileModel =
          Structure.model(name, 'generate_model', false, on: onCommand);
    }

    DartCode dartCode = classGenerator.generateDartClasses(await _jsonRawData);

    String modelPath = _fileModel.path + '_model.dart';
    await writeFile(modelPath, dartCode.result, overwrite: true);
    dartCode.warnings.forEach((warning) =>
        LogService.info('warning: ${warning.path} ${warning.warning} '));
    if (!containsArg('--skipProvider')) {
      List<String> pathSplit = Structure.safeSplitPath(modelPath);
      pathSplit.removeWhere((element) => element == '.' || element == 'lib');
      await handleFileCreate(
        name,
        'provider',
        onCommand,
        onCommand != '',
        ProviderSample(
          name,
          createEndpoints: true,
          modelPath: pathSplit.join('/'),
        ),
        'providers',
      );
    }
  }

  @override
  String get hint => LocaleKeys.hint_generate_model.tr;

  @override
  bool validate() {
    if ((withArgument.isEmpty || p.extension(withArgument) != '.json') &&
        fromArgument.isEmpty) {
      String codeSample =
          'get generate model on home with assets/models/user.json';
      throw CliException(LocaleKeys.error_invalid_json.trArgs([withArgument]),
          codeSample: codeSample);
    }
    return true;
  }

  Future<String> get _jsonRawData async {
    if (withArgument.isNotEmpty) {
      return await File(withArgument).readAsString();
    } else {
      try {
        var result = await get(fromArgument);
        return result.body;
      } catch (e) {
        throw CliException(
            LocaleKeys.error_failed_to_connect.trArgs([fromArgument]));
      }
    }
  }
}
