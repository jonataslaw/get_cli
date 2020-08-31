import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

class PubspecLock {
  static Future<String> getVersionCli({bool disableLog = false}) async {
    try {
      // TODO: See if we are running a debug version or the real CLI.
      var scriptFile = Platform.script.toFilePath();
      var pathToPubLock = join(dirname(scriptFile), '../pubspec.lock');
      final file = File(pathToPubLock);
      var text = loadYaml(await file.readAsString());
//      if (text['packages']['get_cli'] == null) {
//        print("Are running it locally?");
//        return null;
//      }
      var version = text['packages']['get_cli']['version'].toString();
      return version;
    } catch (e) {
      if (!disableLog)
        LogService.error('failed to find the version you have installed.');
      return null;
    }
  }
}
