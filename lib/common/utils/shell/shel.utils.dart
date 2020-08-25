import 'package:get_cli/common/utils/logger/LogUtils.dart';
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
    LogService.info('upgrade get_cli');
    var res =
        await run('pub', ['global', 'activate', 'get_cli'], verbose: true);
    if (res.stderr != null) return LogService.error('falha ao atualizar');
    LogService.success('upgrade complete');
  }
}
