import 'dart:io';

import 'package:cli_dialog/cli_dialog.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

import '../../../../common/utils/json_serialize/model_generator.dart';
import '../../../../common/utils/logger/log_utils.dart';
import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../../core/structure.dart';
import '../../../../exception_handler/exceptions/cli_exception.dart';
import '../../../../functions/create/create_single_file.dart';
import '../../../../models/file_model.dart';
import '../../../../samples/impl/get_provider.dart';
import '../../../interface/command.dart';

class GenerateModelCommand extends Command {
  @override
  String get commandName => 'model';
  @override
  Future<void> execute() async {
    var recursiveDir = onRecursive;

    var suffix = onSuffix;

    if (recursiveDir.isNotEmpty) {
        var current = Directory(recursiveDir);
        final list = current.listSync(recursive: false, followLinks: false);

        for (var element in list) {
          var ext = p.extension(element.path);
          if (ext == ".json") {
            var r_name = p.basenameWithoutExtension(element.path).pascalCase;
            start(r_name, suffix, await _jsonRawData(element.path));
          }
        }
    } else {
      var name = p.basenameWithoutExtension(withArgument);

      if (withArgument.isEmpty) {
        final dialog = CLI_Dialog(questions: [
          [LocaleKeys.ask_model_name.tr, 'name']
        ]);
        var result = dialog.ask()['name'] as String;
        name = result.pascalCase;
      }

      start(name, suffix, await _jsonRawData(withArgument));
    }
  }

  void start(String name, String suffix, String jsonRawData) async {
    FileModel _fileModel;
    final classGenerator = ModelGenerator(
        name + suffix, containsArg('--private'), containsArg('--withCopy'));

    _fileModel = Structure.model(name, 'model', false, on: onCommand);

    var dartCode = classGenerator.generateDartClasses(jsonRawData);

    var modelPath = '${_fileModel.path}_model.dart';

    var model = writeFile(modelPath, dartCode.result, overwrite: true);

    for (var warning in dartCode.warnings) {
      LogService.info('warning: ${warning.path} ${warning.warning} ');
    }
    if (!containsArg('--skipProvider')) {
      var pathSplit = Structure.safeSplitPath(modelPath);
      pathSplit.removeWhere((element) => element == '.' || element == 'lib');
      handleFileCreate(
        name,
        'provider',
        onCommand,
        true,
        ProviderSample(
          name,
          createEndpoints: true,
          modelPath: Structure.pathToDirImport(model.path),
        ),
        'providers',
      );
    }
  }

  @override
  String? get hint => LocaleKeys.hint_generate_model.tr;

  @override
  bool validate() {
    if (onRecursive.isNotEmpty) return true;
    if ((withArgument.isEmpty || p.extension(withArgument) != '.json') &&
        fromArgument.isEmpty) {
      var codeSample =
          'get generate model on home with assets/models/user.json';
      throw CliException(LocaleKeys.error_invalid_json.trArgs([withArgument]),
          codeSample: codeSample);
    }
    return true;
  }

  Future<String> _jsonRawData(String file) async {
    if (file.isNotEmpty) {
      return await File(file).readAsString();
    } else {
      try {
        var result = await get(Uri.parse(fromArgument));
        return result.body;
      } on Exception catch (_) {
        throw CliException(
            LocaleKeys.error_failed_to_connect.trArgs([fromArgument]));
      }
    }
  }

  final String? codeSample1 = LogService.code(
      'get generate model on home with assets/models/user.json');
  final String? codeSample2 = LogService.code(
      'get generate model on home from "https://api.github.com/users/CpdnCristiano"');

  @override
  String get codeSample => '''
  $codeSample1
  or
  $codeSample2
''';

  @override
  int get maxParameters => 0;
}
