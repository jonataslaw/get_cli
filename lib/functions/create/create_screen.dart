import 'dart:io';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_navigation.dart';
import 'package:get_cli/functions/create/create_route.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/arc_screen.dart';
import 'package:get_cli/samples/impl/get_binding.dart';
import 'package:get_cli/samples/impl/get_controller.dart';
import 'package:recase/recase.dart';

import '../../core/structure.dart';

Future<void> createScreen(String name, {bool isExample = false}) async {
  //TODO: Melhorar
  FileModel _fileModel = Structure.model(name, 'screen', true);

  ReCase reCase = ReCase(_fileModel.name);
  await writeFile(_fileModel.path + ".screen.dart",
      ArcScreenSample().file(name, isExample: isExample));

  await writeFile(
      Structure.replaceAsExpected(
              path: 'lib/infrastructure/navigation/bindings/controllers/') +
          '${reCase.snakeCase}.controller.binding.dart',
      BindingSample().file(name, isArc: true));

  await writeFile(
      Structure.replaceAsExpected(
              path: 'lib/presentation/${reCase.snakeCase}/controllers/') +
          '${reCase.snakeCase}.controller.dart',
      ControllerSample().file(name, isArc: !isExample));

  await _addRoute(name);
}

void _addRoute(String nameRoute) async {
  var routesFile = File(Structure.replaceAsExpected(
      path: 'lib/infrastructure/navigation/routes.dart'));
  if (!await routesFile.exists()) {
    await createRoute(isArc: true, initial: nameRoute.snakeCase.toUpperCase());
  }
  var lines = await routesFile.readAsLines();
  String line =
      '  static const ${nameRoute.snakeCase.toUpperCase()} = \'/${nameRoute.snakeCase.toLowerCase().replaceAll('_', '-')}\';';
  if (lines.contains(line)) {
    return;
  }
  while (lines.last.isEmpty) {
    lines.removeLast();
  }

  lines.removeLast();

  lines.add(line);

  _routesSort(lines);

  await routesFile.writeAsStringSync(lines.join('\n'));
  LogService.success('${nameRoute}  route created succesfully ');
  await addNavigation(nameRoute);
}

List<String> _routesSort(List<String> lines) {
  var routes = <String>[];
  var lines2 = <String>[];
  lines2.addAll(lines);
  lines2.forEach((line) {
    if (line.contains('static const')) {
      routes.add('$line');
      lines.remove(line);
    }
  });
  routes.sort();
  lines.addAll(routes);
  lines.add('}');
  return lines;
}
