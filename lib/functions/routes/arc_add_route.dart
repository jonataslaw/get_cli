import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_navigation.dart';
import 'package:get_cli/functions/create/create_route.dart';
import 'package:recase/recase.dart';

Future<void> arcAddRoute(String nameRoute) async {
  File routesFile = File(Structure.replaceAsExpected(
      path: 'lib/infrastructure/navigation/routes.dart'));
  if (!await routesFile.exists()) {
    await createRoute(isArc: true, initial: nameRoute.snakeCase.toUpperCase());
  }
  List<String> lines = await routesFile.readAsLines();
  String line =
      '  static const ${nameRoute.snakeCase.toUpperCase()} = \'/${nameRoute.snakeCase.toLowerCase().replaceAll('_', '-')}\';';
  if (lines.contains(line)) {
    return;
  }
  while (lines.last.isEmpty) {
    /* remover as linhas em branco no final do arquivo 
    gerada pelo o visual studio e outras ide
    */
    lines.removeLast();
  }
// Caso a útima linha seja uma rota exemplo:  static const HOME = '/HOME';}
// diferente do esperado
  if (lines.last.trim() != '}') {
    lines.last = lines.last.replaceAll('}', '');
    lines.add('}');
  }

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
  lines.insertAll(lines.length - 1, routes);
  return lines;
}
