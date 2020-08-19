import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

class PubspecLock {
  static Future<String> getVersionCli() async {
    var pathToPubLock =
        join(dirname(Platform.script.toFilePath()), '../pubspec.lock');
    final file = File(pathToPubLock);
    var text = loadYaml(await file.readAsString());
    return text['packages']['get_cli']['version'].toString();
  }
}
