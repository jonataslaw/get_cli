import 'dart:io';

import 'package:cli_dialog/cli_dialog.dart';
import 'package:get_cli/commands/impl/args_mixin.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/json_serialize/model_generator.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/functions/find_file/find_folder_by_directory.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/get_provider.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

class GenerateModelCommand extends Command with ArgsMixin {
  @override
  Future<void> execute() async {
    String name = p.basenameWithoutExtension(withArgument).pascalCase;
    if (withArgument.isEmpty) {
      final dialog = CLI_Dialog(questions: [
        [
          'Could not set the model name automatically, which name do you want to use?',
          'name'
        ]
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
  String get hint => 'generate Class model from json';

  @override
  bool validate() {
    if ((withArgument.isEmpty || p.extension(withArgument) != '.json') &&
        fromArgument.isEmpty) {
      LogService.error('Enter a path to json file');

      LogService.info(
          'example: \n get generate model on home with assets/models/user.json');
      return false;
    }
    return true;
  }

  Future<String> get _jsonRawData async {
    if (withArgument.isNotEmpty) {
      return await File(withArgument).readAsString();
    } else {
      try {
        var result = await get(fromArgument).then((value) => value);
        return result.body;
      } catch (e) {
        LogService.error('failed to receive json from $fromArgument');
        return null;
      }
    }
  }
}
