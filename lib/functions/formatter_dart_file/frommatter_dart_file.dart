import 'package:dart_style/dart_style.dart';

String formatterDartFile(String content) {
  DartFormatter formatter = DartFormatter();
  return formatter.format(content);
}
