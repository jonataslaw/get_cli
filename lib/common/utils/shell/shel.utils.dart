import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pub_dev/pub_dev_api.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_lock.dart';
import 'package:process_run/process_run.dart';

class ShellUtils {
  static void pubGet() async {
    LogService.info('Running `flutter pub get` …');
    await run('flutter', ['pub', 'get'], verbose: true);
  }

  static void flutterCreate(String path, String org) async {
    LogService.info('Running `flutter create $path` …');
    await run('flutter', ['create', '--org', org, path], verbose: true);
  }

  static void update() async {
    String versionInPubDev =
        await PubDevApi.getLatestVersionFromPackage('get_cli');
    String versionInstalled = await PubspecLock.getVersionCli(disableLog: true);
    if (versionInstalled == versionInPubDev) {
      return LogService.info('Latest version of get_cli already installed');
    }
    LogService.info('Upgrading get_cli …');
    var res;
    if (Platform.script.path.contains('flutter')) {
      res = await run('flutter', ['pub', 'global', 'activate', 'get_cli'],
          verbose: true);
    } else {
      res = await run('pub', ['global', 'activate', 'get_cli'], verbose: true);
    }
    if (res.stderr.toString().isNotEmpty) {
      return LogService.error('There was an error upgrading get_cli');
    }
    LogService.success('Upgrade complete');
  }
}
