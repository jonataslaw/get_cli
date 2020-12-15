import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/shell/shel.utils.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';

class UpdateCommand extends Command {
  @override
  Future<void> execute() async {
    await ShellUtils.update();
  }

  @override
  String get hint => Translation(LocaleKeys.hint_update).tr;

  @override
  bool validate() {
    return true;
  }
}
