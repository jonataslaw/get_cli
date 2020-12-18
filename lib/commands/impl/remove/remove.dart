import '../../../common/utils/logger/LogUtils.dart';
import '../../../common/utils/pubspec/pubspec_utils.dart';
import '../../../common/utils/shell/shel.utils.dart';
import '../../../core/generator.dart';
import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../../interface/command.dart';

class RemoveCommand extends Command {
  @override
  Future<void> execute() async {
    List<String> args = List.from(GetCli.arguments);
    var package = args.first;
    if (args.length == 1) {
      await PubspecUtils.removeDependencies(package);
    } else {
      for (var element in args) {
        await PubspecUtils.removeDependencies(
          element,
        );
      }
    }
    if (GetCli.arguments.first == 'remove') {
      await ShellUtils.pubGet();
    }
  }

  @override
  String get hint => Translation(LocaleKeys.hint_remove).tr;

  @override
  bool validate() {
    List<String> args = List.from(GetCli.arguments);
    args.removeAt(0);
    if (args.isEmpty) {
      LogService.error('Enter the name of the package you wanna remove');
      final codeSample = LogService.code('get remove http');
      LogService.info('''Example:
  $codeSample''');

      return false;
    }
    return true;
  }
}
