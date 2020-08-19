import 'package:get_cli/common/utils/pubspec/pubspec_lock.dart';

versionCommand() async {
  var version = await PubspecLock.getVersionCli();
  if (version == null) return;
  print('''
░██████╗░███████╗████████╗  ░█████╗░██╗░░░░░██╗
██╔════╝░██╔════╝╚══██╔══╝  ██╔══██╗██║░░░░░██║
██║░░██╗░█████╗░░░░░██║░░░  ██║░░╚═╝██║░░░░░██║
██║░░╚██╗██╔══╝░░░░░██║░░░  ██║░░██╗██║░░░░░██║
╚██████╔╝███████╗░░░██║░░░  ╚█████╔╝███████╗██║
░╚═════╝░╚══════╝░░░╚═╝░░░  ░╚════╝░╚══════╝╚═╝
''');
  print('Version: $version');
}
