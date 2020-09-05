import 'package:cli_menu/cli_menu.dart';
import 'package:get_cli/commands/impl/init/init_getxpattern.dart';
import 'package:get_cli/commands/impl/init/init_katteko.dart';
import 'package:get_cli/commands/interface/command.dart';

class InitCommand extends Command {
  @override
  Future<void> execute() async {
    final menu = Menu(['GetX Pattern (by Kauê)', 'CLEAN (by Arktekko)']);
    final result = menu.choose();
    result.index == 0
        ? await createInitGetxPattern()
        : await createInitKatekko();
    return;
  }

  @override
  // TODO: implement hint
  String get hint => throw UnimplementedError();

  @override
  bool validate() {
    // TODO: implement validate
    throw UnimplementedError();
  }
}
