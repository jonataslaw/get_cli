import 'dart:io';

import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/functions/version/check_dev_version.dart';

class PubspecLock {
  static Future<String> getVersionCli({bool disableLog = false}) async {
    try {
      var scriptFile = Platform.script.toFilePath();
      var pathToPubLock = join(dirname(scriptFile), '../pubspec.lock');
      final file = File(pathToPubLock);
      var text = loadYaml(await file.readAsString());
      if (text['packages']['get_cli'] == null) {
        if (isDevVersion()) {
          if (!disableLog) {
            LogService.info('Development version');
          }
        }
        return null;
      }
      var version = text['packages']['get_cli']['version'].toString();
      return version;
    } catch (e) {
      if (!disableLog) {
        LogService.error(
            Translation(LocaleKeys.error_cli_version_not_found).tr);
      }
      return null;
    }
  }
}
