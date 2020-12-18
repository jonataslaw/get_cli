import '../../../common/utils/shell/shel.utils.dart';
import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../../interface/command.dart';

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
