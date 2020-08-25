import 'dart:io';

import 'package:get_cli/core/structure.dart';

Future<void> createListDirectory(List<Directory> dirs) async {
  dirs.forEach((element) async {
    await element.create();
  });
}
