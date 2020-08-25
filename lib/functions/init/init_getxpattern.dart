import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/functions/install/install_get.dart';

import '../create/create_main.dart';
import '../create/create_page.dart';
import '../create/create_route.dart';

Future<void> createInitGetxPattern() async {
  await installGet();
  await createRoute();
  await createMain();
  await createPage();

  LogService.success("init succesfully.");
}
