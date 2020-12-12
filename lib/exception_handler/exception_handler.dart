import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/exception_handler/exceptions/cli_exception.dart';

class ExceptionHandler {
  void handle(dynamic e) {
    if (e is CliException) {
      LogService.error(e.message);
      if (e.codeSample.isNotEmpty) {
        LogService.info('Example');
        print(LogService.codeBold(e.codeSample));
      }
    } else if (e is FileSystemException) {
      if (e.osError.errorCode == 2) {
        LogService.error(' File not found in ${e.path}');
        return;
      } else if (e.osError.errorCode == 13) {
        LogService.error('Access denied to ${e.path}');
        return;
      }
      _logException(e.message);
    } else {
      _logException(e.toString());
    }
    if (!Platform.isWindows) exit(0);
  }

  static void _logException(String msg) {
    LogService.error('''Unexpected error occurred:
$msg
''');
  }
}
