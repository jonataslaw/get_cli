import 'dart:io';

import 'package:path/path.dart';

bool isDevVersion() {
  var scriptFile = Platform.script.toFilePath();
  return basename(scriptFile) == 'get.dart';
}
