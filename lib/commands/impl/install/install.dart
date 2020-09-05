import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/core/generator.dart';

class InstallCommand extends Command {
  @override
  Future<void> execute() async {
    List<String> args = List.from(GetCli.arguments);
    args.removeAt(0);
    var isDev = args.contains('--dev');
    var packageInfo = args.first.split(':');
    LogService.info('Installing package "${packageInfo.first}" …');

    if (packageInfo.length == 1) {
      await PubspecUtils.addDependencies(packageInfo.first, isDev: isDev);
    } else {
      await PubspecUtils.addDependencies(packageInfo.first,
          version: packageInfo[1], isDev: isDev);
    }
  }

  @override
  String get hint => 'Use to install a package in your project (dependencies):';

  @override
  bool validate() {
    List<String> args = List.from(GetCli.arguments);
    args.removeAt(0);
    if (args.isEmpty) {
      LogService.error('Please, enter the name of a package you wanna install');
      final codeSample1 = LogService.code('get install get:3.4.6');
      final codeSample2 = LogService.code('get install get');
      LogService.info('''Example:
  $codeSample1
  if you wanna install the latest version:
  $codeSample2
''');
      return false;
    }
    return true;
  }
}
