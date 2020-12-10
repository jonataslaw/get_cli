import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_navigation.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/functions/formatter_dart_file/frommatter_dart_file.dart';
import 'package:get_cli/samples/impl/arctekko/arc_routes.dart';
import 'package:recase/recase.dart';

Future<void> arcAddRoute(String nameRoute) async {
  File routesFile = File(Structure.replaceAsExpected(
      path: 'lib/infrastructure/navigation/routes.dart'));
  if (!await routesFile.exists()) {
    await ArcRouteSample(nameRoute.snakeCase.toUpperCase()).create();
  } else {
    formatterDartFile(routesFile);
  }
  List<String> lines = await routesFile.readAsLines();
  String line =
      'static const ${nameRoute.snakeCase.toUpperCase()} = \'/${nameRoute.snakeCase.toLowerCase().replaceAll('_', '-')}\';';
  if (lines.contains(line)) {
    return;
  }
  while (lines.last.isEmpty) {
    lines.removeLast();
  }

  lines.add(line);

  _routesSort(lines);

  await writeFile(routesFile.path, lines.join('\n'), overwrite: true);
  LogService.success('${nameRoute} route created successfully.');
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
