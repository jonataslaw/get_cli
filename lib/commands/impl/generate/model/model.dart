import 'dart:io';

import 'package:cli_dialog/cli_dialog.dart';
import 'package:get_cli/commands/impl/generate/generate.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/json_serialize/model_generator.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:recase/recase.dart';

class GenerateModelCommand extends Command with GenerateMixin {
  @override
  Future<void> execute() async {
    String name = basenameWithoutExtension(withArgument ?? '').pascalCase;
    if (withArgument == null) {
      final dialog = CLI_Dialog(questions: [
        [
          'Could not set the model name automatically, which name do you want to use?',
          'name'
        ]
      ]);
      String result = dialog.ask()['name'];
      name = result.pascalCase;
    }
    final classGenerator = ModelGenerator(name);

    FileModel _fileModel =
        Structure.model(name, 'generate_model', false, on: on);

    DartCode dartCode = classGenerator.generateDartClasses(await _jsonRawData);

    await writeFile(_fileModel.path + '_model.dart', dartCode.result,
        overwrite: true);
    dartCode.warnings.forEach((warning) =>
        LogService.info('warning: ${warning.path} ${warning.warning} '));
  }

  @override
  String get hint => 'generate Class model from json';

  @override
  bool validate() {
    if ((withArgument == null || extension(withArgument) != '.json') &&
        fromArgument == null) {
      LogService.error('Enter a path to json file');

      LogService.info(
          'example: \n get generate model on home with assets/models/user.json');
      return false;
    }
    return true;
  }

  Future<String> get _jsonRawData async {
    if (withArgument != null) {
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
