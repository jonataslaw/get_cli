import 'dart:io';

import 'package:get_cli/common/utils/logger/log_utils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_list_directory.dart';
import 'package:get_cli/functions/create/create_main.dart';
import 'package:get_cli/samples/impl/getx_pattern/get_main.dart';
import 'package:get_cli/commands/impl/commads_export.dart';
import 'package:get_cli/commands/impl/install/install_get.dart';

Future<void> createInitGetxPattern() async {
  var canContinue = await createMain();
  if (!canContinue) return;

  var isServerProject = PubspecUtils.isServerProject;
  if (!isServerProject) {
    await installGet();
  }
  var initialDirs = [
    Directory(Structure.replaceAsExpected(path: 'lib/app/data/')),
  ];
  GetXMainSample(isServer: isServerProject).create();
  await Future.wait([
    CreatePageCommand().execute(),
  ]);
  createListDirectory(initialDirs);

  LogService.success(Translation(LocaleKeys.sucess_getx_pattern_generated));
}
