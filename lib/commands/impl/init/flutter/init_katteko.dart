import 'dart:io';

import 'package:get_cli/commands/impl/commads_export.dart';
import 'package:get_cli/commands/impl/install/install_get.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_list_directory.dart';
import 'package:get_cli/functions/create/create_main.dart';
import 'package:get_cli/samples/impl/arctekko/arc_main.dart';
import 'package:get_cli/samples/impl/arctekko/config_example.dart';

Future<void> createInitKatekko() async {
  bool canContinue = await createMain();
  if (!canContinue) return;

  List<Directory> initialDirs = [
    Directory(Structure.replaceAsExpected(path: 'lib/domain/core/interfaces/')),
    Directory(Structure.replaceAsExpected(
        path: 'lib/infrastructure/navigation/bindings/controllers/')),
    Directory(Structure.replaceAsExpected(
        path: 'lib/infrastructure/navigation/bindings/domains/')),
    Directory(
        Structure.replaceAsExpected(path: 'lib/infrastructure/dal/daos/')),
    Directory(
        Structure.replaceAsExpected(path: 'lib/infrastructure/dal/services/')),
    Directory(Structure.replaceAsExpected(path: 'lib/presentation/')),
    Directory(Structure.replaceAsExpected(path: 'lib/infrastructure/theme/')),
  ];
  ArcMainSample().create();
  ConfigExampleSample().create();
  await Future.wait([
    CreateScreenCommand().execute(),
  ]);
  createListDirectory(initialDirs);
  await installGet();

  LogService.success('CLEAN Pattern structure successfully generated.');
}
