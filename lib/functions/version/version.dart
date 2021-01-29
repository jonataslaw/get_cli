import '../../common/utils/pubspec/pubspec_lock.dart';
import 'print_get_cli.dart';

// use from commands/ipml/version/version.dart
@deprecated
Future<void> versionCommand() async {
  var version = await PubspecLock.getVersionCli();
  if (version == null) return;
  printGetCli();
  // ignore: avoid_print
  print('Version: $version');
}
