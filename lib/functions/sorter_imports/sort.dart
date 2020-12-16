import 'dart:convert';

import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/functions/formatter_dart_file/frommatter_dart_file.dart';

String sortImports(String content, String packageName,
    {bool renameImport = false}) {
  content = formatterDartFile(content);

  List<String> lines = LineSplitter.split(content).toList();
  List<String> contentLines = [];
  List<String> dartImports = [];
  List<String> flutterImports = [];
  List<String> packageImports = [];
  List<String> projectRelativeImports = [];
  List<String> projectImports = [];
  bool stringLine = false;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].startsWith('import ') &&
        lines[i].endsWith(';') &&
        !stringLine) {
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
      bool containsThreeQuotes = lines[i].contains("'''");
      if (containsThreeQuotes) {
        stringLine = !stringLine;
      }
      contentLines.add(lines[i]);
    }
  }

  if (renameImport) {
    String separator = PubspecUtils.separatorFileType;
    for (int i = 0; i < projectImports.length; i++) {
      projectImports[i] =
          replacePathTypeSeparator(projectImports[i], separator);
    }
    for (int i = 0; i < projectRelativeImports.length; i++) {
      projectRelativeImports[i] =
          replacePathTypeSeparator(projectRelativeImports[i], separator);
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

  return formatterDartFile(sortedLines.join('\n'));
}
