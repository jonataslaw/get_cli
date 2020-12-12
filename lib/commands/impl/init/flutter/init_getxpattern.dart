import 'dart:io';

import 'package:get_cli/commands/impl/commads_export.dart';
import 'package:get_cli/commands/impl/install/install_get.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_list_directory.dart';
import 'package:get_cli/functions/create/create_main.dart';
import 'package:get_cli/samples/impl/getx_pattern/get_main.dart';

Future<void> createInitGetxPattern() async {
  bool canContinue = await createMain();
  if (!canContinue) return;

  bool isServerProject = PubspecUtils.isServerProject;

  List<Directory> initialDirs = [
    Directory(Structure.replaceAsExpected(path: 'lib/app/data/')),
  ];
  GetXMainSample(isServer: isServerProject).create();
  await Future.wait([
    CreatePageCommand().execute(),
  ]);
  createListDirectory(initialDirs);
  if (!isServerProject) {
    await installGet();
  }

  LogService.success('GetX Pattern structure successfully generated.');
}
