import 'package:get_cli/common/shell.dart';
import 'package:get_cli/functions/install/install.dart';

import '../functions/create/create.dart';
import '../functions/init/init_chooser.dart';

/// Essa função é chamada pela main, e recebe os argumentos da cli
Future<void> generate({
  List<String> arguments,
}) async {
  //TODO Adicionar um logger descente
  final validate = validateArgs(arguments);
  if (!validate) {
    print('Error!!!!!!!!!!!! wrong arguments');
  }

  switch (arguments.first) {
    case "init":
      await createInitial();
      break;
    case "upgrade":
      ShellUtils.update();
      break;
    case "install":
      arguments.removeAt(0);
      installPackage(arguments);
      break;
    case "remove":
      //TODO insert remove funcion
      break;
    case "create":
      await create(arguments);
      break;
  }
}

bool validateArgs(List<String> arguments) {
  List<String> firstArgsAllow = [
    'create',
    'init',
    'upgrade',
    'install',
    'remove'
  ];
  List<String> secondArgsAllow = [
    'page',
    'controller',
    'route',
    'presentation',
    'view'
  ];
  if (arguments != null &&
      arguments.isNotEmpty &&
      firstArgsAllow.contains(arguments.first)) {
    if (arguments.first == 'init' || arguments.first == 'update') return true;

    if (arguments.first == 'create') {
      final secondArg = arguments[1].split(':').first;
      if (secondArgsAllow.contains(secondArg)) return true;
    }

    if (arguments.first == 'install' && arguments.length > 1) return true;
  }
  return false;
}
