import 'dart:convert';
import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/samples/impl/generate_locales.dart';
import 'package:path/path.dart';

Future<void> generateLocales(String inputPath) async {
  if (!await Directory(inputPath).exists()) {
    LogService.error('❌ Error! ${inputPath} directory does not exist.');
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
      LogService.error('''
❌ Error! ${file.path} is not a valid json file.
$e
''');
      return;
    }
  }

  final locales = Map<String, Map<String, String>>();
  maps.forEach((key, value) {
    final result = Map<String, String>();
    _resolveKeys(value, result);
    locales[key] = result;
  });

  final fileModel = Structure.model('locales', 'generate_locales', false);
  final outputFilePath = Structure.replaceAsExpected(path: fileModel.path);

  final keys = Set<String>();
  locales.forEach((key, value) {
    value.forEach((key, value) {
      keys.add(key);
    });
  });

  final parsedKeys = keys.map((e) => '  static const $e = \'$e\';').join('\n');
  var parsedLocales = '\n';
  var translationsKeys = '\n';
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

void _resolveKeys(Map<String, dynamic> localization, Map<String, String> result,
    [String accKey]) {
  final sortedKeys = localization.keys.toList();

  for (var key in sortedKeys) {
    if (localization[key] is Map) {
      var nextAccKey = key;
      if (accKey != null) {
        nextAccKey = '${accKey}_${key}';
      }
      _resolveKeys(localization[key], result, nextAccKey);
    } else {
      result[accKey != null ? '${accKey}_${key}' : key] = localization[key];
    }
  }
}
