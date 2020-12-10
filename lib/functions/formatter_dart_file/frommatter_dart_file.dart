import 'dart:io';

import 'package:dart_style/dart_style.dart';

void formatterDartFile(File file) {
  DartFormatter formatter = DartFormatter();
  file.writeAsStringSync(formatter.format(file.readAsStringSync()));
}
