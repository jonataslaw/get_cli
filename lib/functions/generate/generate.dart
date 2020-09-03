import 'package:get_cli/common/utils/logger/LogUtils.dart';

import './generate_locales.dart';

Future<void> generate(List<String> args) async {
  final command = args[1];

  switch (command) {
    case "locales":
      if (args.length < 3) {
        LogService.error(
            '❌ Error! you need to provide a locales input files dirname.');
        return;
      }
      await generateLocales(args[2]);
      break;

    default:
      break;
  }
  return;
}
