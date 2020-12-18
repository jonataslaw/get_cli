import '../../../common/utils/pubspec/pubspec_lock.dart';
import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../../../functions/version/print_get_cli.dart';
import '../../interface/command.dart';

class VersionCommand extends Command {
  @override
  Future<void> execute() async {
    var version = await PubspecLock.getVersionCli();
    if (version == null) return;
    printGetCli();
    print('Version: $version');
  }

  @override
  String get hint => Translation(LocaleKeys.hint_version).tr;

  @override
  bool validate() {
    return true;
  }
}
