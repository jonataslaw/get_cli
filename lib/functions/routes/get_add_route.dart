import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/functions/routes/get_app_pages.dart';
import 'package:get_cli/functions/find_file/find_file_by_name.dart';
import 'package:get_cli/samples/impl/get_route.dart';
import 'package:recase/recase.dart';

Future<void> addRoute(String nameRoute) async {
  File routesFile = findFileByName('app_routes.dart');
  if (routesFile == null) {
    await RouteSample().create();
    routesFile = File(RouteSample().path);
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

  lines.insert(lines.length - 1, line);

  await routesFile.writeAsStringSync(lines.join('\n'));
  LogService.success('${nameRoute} route created successfully,');

  await addAppPage(nameRoute);
}
