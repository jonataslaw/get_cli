import 'dart:io';

import 'package:version/version.dart';

import '../../cli_config/cli_config.dart';
import '../../common/utils/logger/log_utils.dart';
import '../../common/utils/pub_dev/pub_dev_api.dart';
import '../../common/utils/pubspec/pubspec_lock.dart';
import '../../core/internationalization.dart';
import '../../core/locales.g.dart';
import 'check_dev_version.dart';
import 'print_get_cli.dart';

void checkForUpdate() async {
  if (!CliConfig.updateIsCheckingToday()) {
    if (!isDevVersion()) {
      await PubDevApi.getLatestVersionFromPackage('get_cli')
          .then((versionInPubDev) async {
        await PubspecLock.getVersionCli(disableLog: true)
            .then((versionInstalled) async {
          if (versionInstalled == null) exit(2);

          final v1 = Version.parse(versionInPubDev!);
          final v2 = Version.parse(versionInstalled);
          final needsUpdate = v1.compareTo(v2);
          // needs update.
          if (needsUpdate == 1) {
            LogService.info(Translation(
                    LocaleKeys.info_update_available.trArgs([versionInstalled]))
                .toString());
            //await versionCommand();
            printGetCli();
            final String codeSample = LogService.code('get update');
            LogService.info(
                '${LocaleKeys.info_update_available2.trArgs([
                      versionInPubDev
                    ])}${' $codeSample'}',
                false,
                true);
          }
        });
      });
      CliConfig.setUpdateCheckToday();
    }
  }
}
