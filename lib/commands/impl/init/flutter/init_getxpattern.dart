import 'package:get_cli/commands/impl/commads_export.dart';
import 'package:get_cli/commands/impl/install/install_get.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/functions/create/create_main.dart';
import 'package:get_cli/samples/impl/get_app_pages.dart';
import 'package:get_cli/samples/impl/get_route.dart';
import 'package:get_cli/samples/impl/getx_pattern/get_main.dart';

Future<void> createInitGetxPattern() async {
  bool canContinue = await createMain();
  if (!canContinue) return;

  bool isServerProject = PubspecUtils.isServerProject;

  final import = !isServerProject
      ? "import 'package:get/get.dart';"
      : "import 'package:get_server/get_server.dart';";

  await Future.wait([
    GetXMainSample(isServer: isServerProject).create(),
    RouteSample().create(),
    AppPagesSample(import: import).create(),
    CreatePageCommand().execute(),
  ]);
  await installGet();

  LogService.success('GetX Pattern structure successfully generated.');
}
