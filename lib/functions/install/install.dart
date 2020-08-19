import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/common/utils/shell/shel.utils.dart';
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
  var padkageInfo = args.first.split(':');

  if (padkageInfo.length == 1) {
    await PubspecUtils.addDependencies(padkageInfo.first);
  } else {
    await PubspecUtils.addDependencies(padkageInfo.first,
        version: padkageInfo[1]);
  }
  await ShellUtils.pubGet();
}
