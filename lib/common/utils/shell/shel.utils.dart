import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pub_dev/pub_dev_api.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_lock.dart';
import 'package:process_run/process_run.dart';

class ShellUtils {
  static void pubGet() async {
    LogService.info('run flutter pub get');
    await run('flutter', ['pub', 'get'], verbose: true);
  }

  static void flutterCreate(String path) async {
    LogService.info('run flutter create $path');
    await run('flutter', ['create', '$path'], verbose: true);
  }

  static void update() async {
    String versionInPubDev =
        await PubDevApi.getLatestVersionFromPackage('get_cli');
    String versionInstalled = await PubspecLock.getVersionCli(disableLog: true);
    if (versionInstalled == versionInPubDev)
      return LogService.info('latest version is already installed');
    LogService.info('upgrade get_cli');
    var res =
        await run('pub', ['global', 'activate', 'get_cli'], verbose: true);
    if (res.stderr.toString().isNotEmpty)
      return LogService.error('falha ao atualizar');
    LogService.success('upgrade complete');
  }
}
