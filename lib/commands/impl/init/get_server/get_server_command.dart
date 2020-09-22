import 'dart:io';

import 'package:get_cli/commands/impl/create/page/page.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/functions/create/create_main.dart';
import 'package:get_cli/samples/impl/get_app_pages.dart';
import 'package:get_cli/samples/impl/get_route.dart';
import 'package:get_cli/samples/impl/get_server/pubspec.dart';
import 'package:get_cli/samples/impl/getx_pattern/get_main.dart';
import 'package:path/path.dart';

class InitGetServer extends Command {
  @override
  Future<void> execute() async {
    bool canContinue = await createMain();
    if (!canContinue) return;

    await GetServerPubspecSample(basename(Directory.current.path)).create();
    await PubspecUtils.addDependencies('get_server', runPubGet: false);

    await Future.wait([
      GetXMainSample().create(),
      RouteSample().create(),
      AppPagesSample(
        import: "import 'package:get_server/get_server.dart';",
      ).create(),
      CreatePageCommand().execute(),
    ]);

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
