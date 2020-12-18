import 'dart:io';

import 'package:process_run/process_run.dart';

import '../../../core/generator.dart';
import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../logger/LogUtils.dart';
import '../pub_dev/pub_dev_api.dart';
import '../pubspec/pubspec_lock.dart';

class ShellUtils {
  static void pubGet() async {
    LogService.info('Running `flutter pub get` …');
    await run('flutter', ['pub', 'get'], verbose: true);
  }

  static void flutterCreate(String path, String org) async {
    LogService.info('Running `flutter create $path` …');
    await run('flutter', ['create', '--org', org, path], verbose: true);
  }

  static void update([isGit = false, forceUpdate = false]) async {
    isGit = GetCli.arguments.contains('--git');
    forceUpdate = GetCli.arguments.contains('-f');
    if (!isGit && !forceUpdate) {
      String versionInPubDev =
          await PubDevApi.getLatestVersionFromPackage('get_cli');

      String versionInstalled =
          await PubspecLock.getVersionCli(disableLog: true);

      if (versionInstalled == versionInPubDev) {
        return LogService.info(
            Translation(LocaleKeys.info_cli_last_version_already_installed.tr));
      }
    }

    LogService.info('Upgrading get_cli …');
    var res;
    if (Platform.script.path.contains('flutter')) {
      if (isGit) {
        res = await run(
            'flutter',
            [
              'pub',
              'global',
              'activate',
              '-sgit',
              'https://github.com/jonataslaw/get_cli/'
            ],
            verbose: true);
      } else {
        res = await run(
            'flutter',
            [
              'pub',
              'global',
              'activate',
              'get_cli',
            ],
            verbose: true);
      }
    } else {
      if (isGit) {
        res = await run(
            'pub',
            [
              'global',
              'activate',
              '-sgit',
              'https://github.com/jonataslaw/get_cli/'
            ],
            verbose: true);
      } else {
        res = await run(
            'pub',
            [
              'global',
              'activate',
              'get_cli',
            ],
            verbose: true);
      }
    }
    if (res.stderr.toString().isNotEmpty) {
      return LogService.error(LocaleKeys.error_update_cli.tr);
    }
    LogService.success(LocaleKeys.sucess_update_cli.tr);
  }
}
