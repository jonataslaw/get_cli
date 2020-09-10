import 'dart:io';

import 'package:get_cli/commands/impl/generate/generate.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:json_to_dart/json_to_dart.dart';
import 'package:path/path.dart';
import 'package:recase/recase.dart';

class GenerateModelCommand extends Command with GenerateMixin {
  @override
  Future<void> execute() async {
    final classGenerator =
        ModelGenerator(basenameWithoutExtension(withArguments).pascalCase);

    FileModel _fileModel = Structure.model(
        basenameWithoutExtension(withArguments).pascalCase,
        'generate_model',
        false,
        on: on);
    final jsonRawData = File(withArguments).readAsStringSync();
    DartCode dartCode = classGenerator.generateDartClasses(jsonRawData);
    await writeFile(_fileModel.path + '_model.dart', dartCode.result,
        overwrite: true);
    dartCode.warnings.forEach((warning) =>
        LogService.info('warning: ${warning.path} ${warning.warning} '));
  }

  @override
  String get hint => 'generate Class model from json';

  @override
  bool validate() {
    if (withArguments == null) {
      LogService.error('Enter a path to json file');

      LogService.info(
          'example: \n get generate model on home with assets/models/user.json');
      return false;
    }
    if (extension(withArguments) != '.json') {
      LogService.error('Enter a path to json file valid');

      LogService.info(
          'example: \n get generate model on home with assets/models/user.json');
      return false;
    }
    return true;
  }
}
