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
      //TODO insert upgrade funcion
      break;
    case "install":
      //TODO insert install funcion
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
    if (arguments.first == 'init') return true;
    final secondArg = arguments[1].split(':').first;
    if (secondArgsAllow.contains(secondArg)) return true;
  }
  return false;
}
