import 'package:get_cli/commands/impl/create/page/page.dart';
import 'package:get_cli/commands/impl/install/install_get.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/functions/create/create_app_pages.dart';
import 'package:get_cli/functions/create/create_main.dart';
import 'package:get_cli/functions/create/create_route.dart';

Future<void> createInitGetxPattern() async {
  bool canContinue = await createMain();
  if (!canContinue) return;

  await Future.wait([
    createRoute(),
    createAppPage(),
    CreatePageCommand().execute(),
  ]);
  await installGet();

  LogService.success('GetX Pattern structure successfully generated.');
}
