import 'package:get_cli/common/menu/menu.dart';
import 'package:get_cli/common/utils/logger/log_utils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/common/utils/shell/shel.utils.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/commands/impl/init/flutter/init_getxpattern.dart';
import 'package:get_cli/commands/impl/init/flutter/init_katteko.dart';

class InitCommand extends Command {
  @override
  String get commandName => 'init';

  @override
  Future<void> execute() async {
    final menu = Menu(
      [
        'GetX Pattern (by Kauê)',
        'CLEAN (by Arktekko)',
      ],
      title: 'Which architecture do you want to use?',
    );
    final result = menu.choose();

    result.index == 0
        ? await createInitGetxPattern()
        : await createInitKatekko();
    if (!PubspecUtils.isServerProject) {
      await ShellUtils.pubGet();
    }
    return;
  }

  @override
  String? get hint => Translation(LocaleKeys.hint_init).tr;

  @override
  bool validate() {
    super.validate();
    return true;
  }

  @override
  String? get codeSample => LogService.code('get init');

  @override
  int get maxParameters => 0;
}
