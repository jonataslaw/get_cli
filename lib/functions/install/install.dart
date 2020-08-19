import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import '../../common/utils/logger/LogUtils.dart';

Future<void> installPackage(List<String> args) async {
  if (args.isEmpty) {
    LogService.error('enter the name of a package');
    LogService.info('''exemple:
  get install get:3.4.6
  or 
  get intall get
  that way the latest version will be installed''');
    return;
  }
  var isDev = args.contains('--dev');
  var packageInfo = args.first.split(':');
  LogService.info('intalling package: ${packageInfo.first}');

  if (packageInfo.length == 1) {
    await PubspecUtils.addDependencies(packageInfo.first, isDev: isDev);
  } else {
    await PubspecUtils.addDependencies(packageInfo.first,
        version: packageInfo[1], isDev: isDev);
  }
}
