import 'dart:io';

import 'package:get_cli/commands/impl/commads_export.dart';
import 'package:get_cli/commands/impl/install/install_get.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/common/utils/shell/shel.utils.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_list_directory.dart';
import 'package:get_cli/functions/create/create_main.dart';
import 'package:get_cli/samples/impl/arctekko/arc_main.dart';
import 'package:get_cli/samples/impl/arctekko/config_example.dart';

Future<void> createInitKatekko() async {
  bool canContinue = await createMain();
  if (!canContinue) return;
  if (!PubspecUtils.isServerProject) {
    await installGet();
  }
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
  if (!PubspecUtils.isServerProject) {
    await ShellUtils.pubGet();
  }

  LogService.success(Translation(LocaleKeys.sucess_CLEAN_Pattern_generated));
}
