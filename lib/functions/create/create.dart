import 'package:get_cli/functions/create/create_page.dart';
import 'package:get_cli/functions/create/create_route.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/samples/impl/get_controller.dart';
import 'package:get_cli/samples/impl/get_view.dart';

Future<void> create(List<String> args) async {
  final name = args[1].split(':').last;
  final command = args[1].split(':').first;

  String onCommand;
  print(args.length);
  if (args.length > 2 && args[2] == 'on') {
    onCommand = args[3];
  }

  switch (command) {
    case "page":
      await createPage(name);
      break;
    case "controller":
      await handleFileCreate(
          name, 'controller', onCommand, false, ControllerSample());
      break;
    case "view":
      await handleFileCreate(name, 'view', onCommand, false, GetViewSample());
      break;
    case "route":
      await createRoute();
      break;
  }
  return;
}

// Future<void> create(List<String> args) async {
//   print('comando é create');
//   final menu = Menu(['page', 'controller', 'view', 'route']);
//   final result = menu.choose();

//   switch (result.value) {
//     case "page":
//       await createPage();
//       break;
//     case "controller":
//       //  await createController();
//       break;
//     case "view":
//       //  await createView();
//       break;
//     case "route":
//       await createRoute();
//       break;
//   }
//   return;
// }
