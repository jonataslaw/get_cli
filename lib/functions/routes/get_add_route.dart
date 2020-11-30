import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/functions/routes/get_app_pages.dart';
import 'package:get_cli/functions/find_file/find_file_by_name.dart';
import 'package:get_cli/samples/impl/get_route.dart';
import 'package:recase/recase.dart';

Future<void> addRoute(String nameRoute, String path) async {
  File routesFile = findFileByName('app_routes.dart');
  if (routesFile == null) {
    await RouteSample().create();
    routesFile = File(RouteSample().path);
  }
  List<String> pathSplit = path.split('/');
  pathSplit.removeLast();
  pathSplit.removeWhere((element) => element == 'app' || element == 'modules');
  pathSplit.add(nameRoute);
  for (var i = 0; i < pathSplit.length; i++) {
    pathSplit[i] =
        pathSplit[i].snakeCase.snakeCase.toLowerCase().replaceAll('_', '-');
  }
  print(pathSplit);
  String route = pathSplit.join('/');
  List<String> lines = routesFile.readAsLinesSync();
  String line =
      "\tstatic const ${nameRoute.snakeCase.toUpperCase()} = '/$route';";
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

  await addAppPage(nameRoute, path);
}
