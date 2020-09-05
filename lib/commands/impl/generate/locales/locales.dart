import 'dart:convert';
import 'dart:io';

import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/get_cli.dart';
import 'package:get_cli/samples/impl/generate_locales.dart';
import 'package:path/path.dart';

class GenerateLocalesCommand extends Command {
  @override
  String get hint => 'Generate a localization file';

  @override
  bool validate() {
    final isValid = GetCli.arguments.length > 2;
    if (!isValid) {
      LogService.error('you need to provide a locales input files dirname.');
    }
    return isValid;
  }

  @override
  Future<void> execute() async {
    final inputPath = GetCli.arguments[2];
    final fileModel = Structure.model('locales', 'generate_locales', false);
    final outputFilePath = Structure.replaceAsExpected(path: fileModel.path);

    if (!await Directory(inputPath).exists()) {
      LogService.error('${inputPath} directory does not exist.');
      return;
    }

    final files = await Directory(inputPath)
        .list(recursive: false)
        .where((FileSystemEntity entry) => entry.path.endsWith('.json'))
        .toList();

    if (files.isEmpty) {
      LogService.info('input directory is empty.');
      return;
    }

    final maps = Map<String, Map<String, dynamic>>();
    for (var file in files) {
      try {
        final map = jsonDecode(await File(file.path).readAsString());
        final localeKey = basename(file.path).split('.').first;
        maps[localeKey] = map;
      } catch (e) {
        LogService.error('${file.path} is not a valid json file\n$e');
        return;
      }
    }

    final locales = Map<String, Map<String, String>>();
    maps.forEach((key, value) {
      final result = Map<String, String>();
      _resolve(value, result);
      locales[key] = result;
    });

    final keys = Set<String>();
    locales.forEach((key, value) {
      value.forEach((key, value) {
        keys.add(key);
      });
    });

    final parsedKeys =
        keys.map((e) => '  static const $e = \'$e\';').join('\n');

    var parsedLocales = '\n';
    var translationsKeys = '';
    locales.forEach((key, value) {
      parsedLocales += '  static const $key = {\n';
      translationsKeys += '    \'$key\' : Locales.$key,\n';
      value.forEach((key, value) {
        parsedLocales += '   \'$key\': \'$value\',\n';
      });
      parsedLocales += '  };\n';
    });

    try {
      final content = GenerateLocalesSample().file('generate_locales',
          locales: parsedLocales,
          keys: parsedKeys,
          translationsKeys: translationsKeys);
      await writeFile(outputFilePath + '.g.dart', content, overwrite: true);
    } catch (e) {
      LogService.error('''
❌ Error! localization file is not created.
$e
''');
      return;
    }

    LogService.success('locale files generated successfully.');
  }

  void _resolve(Map<String, dynamic> localization, Map<String, String> result,
      [String accKey]) {
    final sortedKeys = localization.keys.toList();

    for (var key in sortedKeys) {
      if (localization[key] is Map) {
        var nextAccKey = key;
        if (accKey != null) {
          nextAccKey = '${accKey}_${key}';
        }
        _resolve(localization[key], result, nextAccKey);
      } else {
        result[accKey != null ? '${accKey}_${key}' : key] = localization[key];
      }
    }
  }
}
