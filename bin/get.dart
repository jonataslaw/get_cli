import 'package:get_cli/common/utils/logger/log_utils.dart';
import 'package:get_cli/exception_handler/exception_handler.dart';
import 'package:get_cli/functions/version/version_update.dart';
import 'package:get_cli/get_cli.dart';

Future<void> main(List<String> arguments) async {
  var time = Stopwatch();
  time.start();
  final command = GetCli(arguments).findCommand();

  try {
    if (command.validate()) {
      await command.execute().then((value) {
        if (!arguments.contains('--no-version-check')) {
          checkForUpdate();
        }
      });
    }
  } on Exception catch (e) {
    if (arguments.contains('--debug')) {
      rethrow;
    }
    ExceptionHandler().handle(e);
  }
  time.stop();
  LogService.info('Time: ${time.elapsed.inMilliseconds} Milliseconds');
}

/* void main(List<String> arguments) {
 Core core = Core();
  core
      .generate(arguments: List.from(arguments))
      .then((value) => checkForUpdate()); 
} */
