import 'package:get_cli/get_cli.dart';

main(List<String> arguments) {
  Core core = Core();
  core.generate(arguments: List.from(arguments));
}
