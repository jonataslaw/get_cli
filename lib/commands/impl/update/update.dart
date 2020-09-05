import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/shell/shel.utils.dart';

class UpdateCommand extends Command {
  @override
  Future<void> execute() async {
    await ShellUtils.update();
  }

  @override
  String get hint => 'To update CLI';

  @override
  bool validate() {
    return true;
  }
}
