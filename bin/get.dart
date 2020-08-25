import 'package:get_cli/get_cli.dart';

main(List<String> arguments) async {
  // não sei se é útil, desativado por enquanto
  /*  await PubDevApi.getLatestVersionFromPackage('get_cli')
      .then((versionInPubDev) async {
    String versionInstalled = await PubspecLock.getVersionCli(disableLog: true);
    if (versionInstalled != versionInPubDev) {
      LogService.info('a new version is available');
      LogService.info('Run: get update');
    }
  }); */

  Core core = Core();
  core.generate(arguments: List.from(arguments));
}
