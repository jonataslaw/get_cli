import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

class PubspecLock {
  static Future<String> getVersionCli({bool disableLog = false}) async {
    try {
      var pathToPubLock =
          join(dirname(Platform.script.toFilePath()), '../pubspec.lock');
      final file = File(pathToPubLock);
      var text = loadYaml(await file.readAsString());
      return text['packages']['get_cli']['version'].toString();
    } catch (e) {
      if (!disableLog) LogService.error('failed to find version');

      return null;
    }
  }
}
