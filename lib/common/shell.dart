import 'dart:developer';

import 'package:process_run/process_run.dart';

class ShellUtils {
  static void pubGet() async {
    print('run flutter pub get');
    await run('flutter', ['pub', 'get'], verbose: true);
  }

  static void update() async {
    //TODO: melhorar log
    print('upgrade get_cli');
    await run('pub', ['global', 'activate', 'get_cli'], verbose: false);
    print('upgrade complete');
  }
}
