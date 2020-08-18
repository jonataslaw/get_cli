import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/functions/shell/pubget.dart';

void commandInstall(List<String> args) async {
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

  PubspecUtils utils = PubspecUtils();
  if (padkageInfo.length == 1) {
    await utils.addDependencies(padkageInfo.first);
  } else {
    await utils.addDependencies(padkageInfo.first, version: padkageInfo[1]);
  }
  await ShellUtils.pubGet();
}
