import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pub_dev/pub_dev_api.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_lock.dart';
import 'package:get_cli/get_cli.dart';

main(List<String> arguments) async {
  // acho melhor criar uma nova fuction
  await PubDevApi.getLatestVersionFromPackage('get_cli')
      .then((versionInPubDev) async {
    String versionInstalled = await PubspecLock.getVersionCli(disableLog: true);
    if (versionInstalled != versionInPubDev) {
      LogService.info('a new version is available');
      LogService.info('Run: get update');
    }
  });

  Core core = Core();
  core.generate(arguments: List.from(arguments));
}
