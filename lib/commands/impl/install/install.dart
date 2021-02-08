import '../../../common/utils/logger/log_utils.dart';
import '../../../common/utils/pubspec/pubspec_utils.dart';
import '../../../common/utils/shell/shel.utils.dart';
import '../../../core/generator.dart';
import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../../../exception_handler/exceptions/cli_exception.dart';
import '../../interface/command.dart';

class InstallCommand extends Command {
  @override
  String get commandName => 'install';
  @override
  List<String> get alias => ['-i'];
  @override
  Future<void> execute() async {
    var args = List<String>.from(GetCli.arguments);
    args.removeAt(0);
    var isDev = containsArg('--dev') || containsArg('-dev');
    var runPubGet = true;

    if (args.length == 1) {
      var packageInfo = args.first.split(':');
      LogService.info('Installing package "${packageInfo.first}" …');
      if (packageInfo.length == 1) {
        runPubGet = await PubspecUtils.addDependencies(packageInfo.first,
            isDev: isDev, runPubGet: false);
      } else {
        runPubGet = await PubspecUtils.addDependencies(packageInfo.first,
            version: packageInfo[1], isDev: isDev, runPubGet: false);
      }
    } else {
      for (var element in args) {
        var packageInfo = element.split(':');
        LogService.info('Installing package "${packageInfo.first}" …');
        if (packageInfo.length == 1) {
          await PubspecUtils.addDependencies(packageInfo.first,
              isDev: isDev, runPubGet: false);
        } else {
          await PubspecUtils.addDependencies(packageInfo.first,
              version: packageInfo[1], isDev: isDev, runPubGet: false);
        }
      }
    }
    if (runPubGet) await ShellUtils.pubGet();
  }

  @override
  String get hint => Translation(LocaleKeys.hint_install).tr;

  @override
  bool validate() {
    var args = List<String>.from(GetCli.arguments);
    args.removeAt(0);
    if (args.isEmpty) {
      final codeSample1 = LogService.code('get install get:3.4.6');
      final codeSample2 = LogService.code('get install get');
      throw CliException(
          'Please, enter the name of a package you wanna install',
          codeSample: '''
  $codeSample1
  if you wanna install the latest version:
  $codeSample2
''');
    }
    return true;
  }
}
