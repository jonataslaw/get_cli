import 'dart:io';

import 'package:get_cli/common/utils/shell/shel.utils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:recase/recase.dart';

@deprecated
Future<void> createProject(String name) async {
  String path = name == '.'
      ? Directory.current.path
      : Structure.replaceAsExpected(
          path: Directory.current.path + '/${name.snakeCase}');

  await ShellUtils.flutterCreate(path, 'com.exemple');
  Directory.current = path;
  //await createInitial();
}
