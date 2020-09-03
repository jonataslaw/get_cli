import 'package:cli_menu/cli_menu.dart';
import 'package:get_cli/functions/init/init_getxpattern.dart';
import 'package:get_cli/functions/init/init_katteko.dart';

Future<void> createInitial() async {
  final menu = Menu(['GetX Pattern (by Kauê)', 'CLEAN (by Arktekko)']);
  final result = menu.choose();
  result.index == 0 ? await createInitGetxPattern() : await createInitKatekko();
  return;
}
