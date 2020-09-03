import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/functions/version/check_dev_version.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

class PubspecLock {
  static Future<String> getVersionCli({bool disableLog = false}) async {
    try {
      var scriptFile = Platform.script.toFilePath();
      var pathToPubLock = join(dirname(scriptFile), '../pubspec.lock');
      final file = File(pathToPubLock);
      var text = loadYaml(await file.readAsString());
      if (text['packages']['get_cli'] == null) {
        if (isDevVersion()) {
          LogService.info('Development version');
        }
        return null;
      }
      var version = text['packages']['get_cli']['version'].toString();
      return version;
    } catch (e) {
      if (!disableLog) {
        LogService.error('failed to find the version you have installed.');
      }
      return null;
    }
  }
}
