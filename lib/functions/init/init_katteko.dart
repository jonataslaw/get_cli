import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/functions/install/install_get.dart';
import '../create/create_screen.dart';
import '../create/create_main.dart';
import '../create/create_route.dart';

Future<void> createInitKatekko() async {
  await Future.wait([
    createRoute(isArc: true, initial: 'COUNTER'),
    createMain(isArc: true),
    createScreen('Counter', isExample: true),
  ]);

  await installGet();

  LogService.success("Succesfully.");
}
