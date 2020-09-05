import 'package:get_cli/common/utils/pubspec/pubspec_lock.dart';
import 'package:get_cli/functions/version/print_get_cli.dart';

// use from commands/ipml/version/version.dart
@deprecated
Future<void> versionCommand() async {
  var version = await PubspecLock.getVersionCli();
  if (version == null) return;
  printGetCli();
  print('Version: $version');
}
