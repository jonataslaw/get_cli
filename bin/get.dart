import 'package:get_cli/functions/version/version_update.dart';
import 'package:get_cli/get_cli.dart';

void main(List<String> arguments) {
  Core core = Core();
  core
      .generate(arguments: List.from(arguments))
      .then((value) => checkForUpdate());
}
