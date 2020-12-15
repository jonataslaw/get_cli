import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:recase/recase.dart';

import 'package:get_cli/commands/impl/args_mixin.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/exception_handler/exceptions/cli_exception.dart';
import 'package:get_cli/get_cli.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/generate_locales.dart';

class GenerateLocalesCommand extends Command with ArgsMixin {
  @override
  String get hint => Translation(LocaleKeys.hint_generate_locales).tr;

  @override
  bool validate() {
    return true;
  }

  @override
  Future<void> execute() async {
    final inputPath = args.length >= 3 ? GetCli.arguments[2] : 'assets/locales';

    if (!await Directory(inputPath).exists()) {
      LogService.error(
          LocaleKeys.error_nonexistent_directory.trArgs([inputPath]));
      return;
    }

    final files = await Directory(inputPath)
        .list(recursive: false)
        .where((FileSystemEntity entry) => entry.path.endsWith('.json'))
        .toList();

    if (files.isEmpty) {
      LogService.info(LocaleKeys.error_empty_directory.trArgs([inputPath]));
      return;
    }

    final maps = Map<String, Map<String, dynamic>>();
    for (var file in files) {
      try {
        final map = jsonDecode(await File(file.path).readAsString());
        final localeKey = basenameWithoutExtension(file.path);
        maps[localeKey] = map;
      } catch (e) {
        LogService.error(LocaleKeys.error_invalid_json.trArgs([file.path]));
        rethrow;
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
        keys.map((e) => '\tstatic const $e = \'$e\';').join('\n');

    final parsedLocales = StringBuffer('\n');
    final translationsKeys = StringBuffer();
    locales.forEach((key, value) {
      parsedLocales.writeln('\tstatic const $key = {');
      translationsKeys.writeln('\t\t\'$key\' : Locales.$key,');
      value.forEach((key, value) {
        key = key.snakeCase;
        value = _replaceValue(value);
        if (RegExp(r'^[0-9]|[!@#<>?":`~;[\]\\|=+)(*&^%-\s]').hasMatch(key)) {
          throw CliException(
              LocaleKeys.error_special_characters_in_key.trArgs([key]));
        }
        parsedLocales.writeln('\t\t\'$key\': \'$value\',');
      });
      parsedLocales.writeln('\t};');
    });

    FileModel _fileModel =
        Structure.model('locales', 'generate_locales', false, on: onCommand);

    await GenerateLocalesSample(
            parsedKeys, parsedLocales.toString(), translationsKeys.toString(),
            path: _fileModel.path + '.g.dart')
        .create();

    LogService.success(LocaleKeys.sucess_locale_generate.tr);
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

String _replaceValue(String value) {
  return value.replaceAll("'", "\\'").replaceAll('\n', '\\n');
}
