import 'package:cli_menu/cli_menu.dart';
import 'package:get_cli/commands/impl/init/flutter/init_getxpattern.dart';
import 'package:get_cli/commands/impl/init/flutter/init_katteko.dart';
import 'package:get_cli/commands/interface/command.dart';

class InitCommand extends Command {
  @override
  Future<void> execute() async {
    final menu = Menu([
      'GetX Pattern (by Kauê)',
      'CLEAN (by Arktekko)',
    ]);
    final result = menu.choose();
    result.index == 0
        ? await createInitGetxPattern()
        : await createInitKatekko();
    return;
  }

  @override
  String get hint => 'generate the chosen structure on an existing project:';

  @override
  bool validate() {
    return true;
  }
}
