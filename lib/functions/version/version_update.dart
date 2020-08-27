import '../../common/utils/logger/LogUtils.dart';
import '../../common/utils/pub_dev/pub_dev_api.dart';
import '../../common/utils/pubspec/pubspec_lock.dart';
import 'version.dart';

void checkForUpdate() {
  PubDevApi.getLatestVersionFromPackage('get_cli')
      .then((versionInPubDev) async {
    PubspecLock.getVersionCli(disableLog: true).then((versionInstalled) async {
      if (versionInstalled != versionInPubDev) {
        LogService.info('A NEW VERSION IS AVAILABLE!');
        await versionCommand();
        LogService.info('VERSION AVAILABLE: $versionInPubDev');
        LogService.info('Run: get update');
      }
    });
  });
}
