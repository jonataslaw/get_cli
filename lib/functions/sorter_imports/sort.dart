import 'dart:convert';

import 'package:get_cli/functions/formatter_dart_file/frommatter_dart_file.dart';

String sortImports(
  String content,
  String packageName,
) {
  content = formatterDartFile(content);

  List<String> lines = LineSplitter.split(content).toList();
  List<String> contentLines = [];
  List<String> dartImports = [];
  List<String> flutterImports = [];
  List<String> packageImports = [];
  List<String> projectRelativeImports = [];
  List<String> projectImports = [];

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].startsWith('import ') && lines[i].endsWith(';')) {
      if (lines[i].contains('dart:')) {
        dartImports.add(lines[i]);
      } else if (lines[i].contains('package:flutter/')) {
        flutterImports.add(lines[i]);
      } else if (lines[i].contains('package:$packageName/')) {
        projectImports.add(lines[i]);
      } else if (!lines[i].contains('package:')) {
        projectRelativeImports.add(lines[i]);
      } else if (lines[i].contains('package:')) {
        if (!lines[i].contains('package:flutter/')) {
          packageImports.add(lines[i]);
        }
      }
    } else {
      contentLines.add(lines[i]);
    }
  }

  if (dartImports.isEmpty &&
      flutterImports.isEmpty &&
      packageImports.isEmpty &&
      projectImports.isEmpty &&
      projectRelativeImports.isEmpty) {
    return content;
  }
  dartImports.sort();
  flutterImports.sort();
  packageImports.sort();
  projectImports.sort();
  projectRelativeImports.sort();

  List<String> sortedLines = [];

  sortedLines
    ..addAll(dartImports)
    ..add('')
    ..addAll(flutterImports)
    ..add('')
    ..addAll(packageImports)
    ..add('')
    ..addAll(projectImports)
    ..addAll(projectRelativeImports)
    ..add('')
    ..addAll(contentLines);

  return formatterDartFile(content);
}
