import 'dart:developer';
import 'dart:io';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_navigation.dart';
import 'package:get_cli/functions/create/create_route.dart';
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
  File _screen = File(_fileModel.path + ".screen.dart");
  // os if são para não sobrescrever caso ja exista um arquivo
  if (!await _screen.exists()) {
    await _screen.create(recursive: true);
    await _screen
        .writeAsString(ArcScreenSample().file(name, isExample: isExample));
    LogService.success(reCase.pascalCase + " Screen created succesfully.");
  }
  File _binding = await File(Structure.replaceAsExpected(
          path: 'lib/infrastructure/navigation/bindings/controllers/') +
      '${reCase.snakeCase}.controller.binding.dart');
  if (!await _binding.exists()) {
    await _binding.create(recursive: true);
    await _binding.writeAsString(BindingSample().file(name, isArc: true));
    LogService.success(reCase.pascalCase + " Binding created succesfully.");
  }
  File _controller = await File(Structure.replaceAsExpected(
          path: 'lib/presentation/${reCase.snakeCase}/controllers/') +
      '${reCase.snakeCase}.controller.dart');
  if (!await _controller.exists()) {
    await _controller.create(recursive: true);
    await _controller.writeAsString(isExample
        ? ControllerSample().file(name)
        : ControllerSample().file(name, isArc: true));
    LogService.success(reCase.pascalCase + " controller created succesfully.");
  }

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
