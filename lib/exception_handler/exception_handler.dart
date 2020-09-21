import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/exception_handler/exceptions/cli_exception.dart';

class ExceptionHandler {
  void handle(Exception e) {
    if (e is CliException) {
      LogService.error(e.message);
      if (e.codeSample != null) {
        LogService.info(e.codeSample);
      }
    } else if (e is FileSystemException) {
      if (e.osError.errorCode == 2) {
        LogService.error('pubspec.yaml not found in current directory, '
            'are you in the root folder of your project?');
        return;
      } else if (e.osError.errorCode == 13) {
        LogService.error('You are not allowed to access pubspec.yaml');
        return;
      }
      _logException(e.message);
    } else {
      _logException(e.runtimeType.toString());
    }
    exit(0);
  }

  static void _logException(String msg) {
    LogService.error('''Unexpected error occurred:
$msg
''');
  }
}
