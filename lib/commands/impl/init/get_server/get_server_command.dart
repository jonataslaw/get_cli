import 'dart:io';

import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_list_directory.dart';
import 'package:get_cli/functions/create/create_main.dart';
import 'package:get_cli/samples/impl/get_app_pages.dart';
import 'package:get_cli/samples/impl/get_route.dart';
import 'package:get_cli/samples/impl/get_server/get_server_main.dart';
import 'package:get_cli/samples/impl/get_server/pubspec.dart';
import 'package:path/path.dart';

class InitGetServer extends Command {
  @override
  Future<void> execute() async {
    bool canContinue = await createMain();
    if (!canContinue) return;

    List<Directory> initialDirs = [
      Directory(Structure.replaceAsExpected(path: 'lib/data')),
      Directory(Structure.replaceAsExpected(path: 'lib/pages')),
      Directory(Structure.replaceAsExpected(path: 'lib/routes')),
      Directory(Structure.replaceAsExpected(path: 'lib/widgets')),
    ];
    await Future.wait([
      GetServerMainSample().create(),
      AppPagesSample(
              import: '''import 'package:get_server/get_server.dart';''',
              initial: null,
              path: 'lib/routes/app_pages.dart')
          .create(),
      GetServerPubspecSample(basename(Directory.current.path)).create(),
      RouteSample(path: 'lib/routes/app_routes.dart').create(),
      createListDirectory(initialDirs),
    ]);
    await PubspecUtils.addDependencies('get_server', runPubGet: false);
    await PubspecUtils.addDependencies('pedantic',
        isDev: true, runPubGet: false);
    await PubspecUtils.addDependencies('test', isDev: true, runPubGet: true);
  }

  @override
  String get hint => 'Generate the  structure initial for get server';

  @override
  bool validate() {
    return true;
  }
}
