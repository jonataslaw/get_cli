import 'dart:io';

import 'package:get_cli/core/structure.dart';
import 'package:path/path.dart';
import 'package:recase/recase.dart';

String findBindingFromName(String path, String name) {
  path = Structure.replaceAsExpected(path: path);
  List<String> splitPath = Structure.safeSplitPath(path);
  splitPath
    ..remove('.')
    ..removeLast();

  String bindingPath = '';
  while (splitPath.isNotEmpty && bindingPath == '') {
    Directory(splitPath.join(separator))
        .listSync(recursive: true, followLinks: false)
        .forEach((element) {
      if (element is File) {
        String fileName = basename(element.path);
        if (fileName == '${name.snakeCase}_binding.dart' ||
            fileName == '${name.snakeCase}.controller.binding.dart') {
          bindingPath = element.path;
        }
      }
    });
    splitPath.removeLast();
  }
  return bindingPath;
}
