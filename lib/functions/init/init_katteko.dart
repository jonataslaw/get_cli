import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/samples/impl/get_controller.dart';

import '../create/create_screen.dart';
import '../create/create_main.dart';
import '../create/create_route.dart';

Future<void> createInitKatekko() async {
  await createRoute(isArc: true, initial: 'COUNTER');
  await createMain(isArc: true);
  await createScreen('Counter', isExample: true);

  LogService.success("Succesfully.");
}
