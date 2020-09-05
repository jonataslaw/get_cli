import 'package:get_cli/functions/version/version_update.dart';
import 'package:get_cli/get_cli.dart';

Future<void> main(List<String> arguments) async {
  final command = GetCli(arguments).findCommand();
  if (command != null && command.validate()) {
    await command.execute().then((value) => checkForUpdate());
  }
}

/* void main(List<String> arguments) {
 Core core = Core();
  core
      .generate(arguments: List.from(arguments))
      .then((value) => checkForUpdate()); 
} */
