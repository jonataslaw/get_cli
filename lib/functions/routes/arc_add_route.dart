import 'dart:convert';
import 'dart:io';

import 'package:recase/recase.dart';

import 'package:get_cli/common/utils/logger/log_utils.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/samples/impl/arctekko/arc_routes.dart';
import 'package:get_cli/functions/create/create_navigation.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/functions/formatter_dart_file/frommatter_dart_file.dart';

void arcAddRoute(String nameRoute) {
  var routesFile = File(
    Structure.replaceAsExpected(
      path: 'lib/infrastructure/navigation/routes.dart',
    ),
  );
  var lines = <String>[];
  if (!routesFile.existsSync()) {
    ArcRouteSample(nameRoute.snakeCase.toUpperCase()).create();
    lines = routesFile.readAsLinesSync();
  } else {
    var content = formatterDartFile(routesFile.readAsStringSync());
    lines = LineSplitter.split(content).toList();
  }

  var line =
      'static const ${nameRoute.snakeCase.toUpperCase()} = \'/${nameRoute.snakeCase.toLowerCase().replaceAll('_', '-')}\';';
  if (lines.contains(line)) {
    return;
  }
  while (lines.last.isEmpty) {
    lines.removeLast();
  }

  lines.add(line);

  _routesSort(lines);

  writeFile(routesFile.path, lines.join('\n'), overwrite: true);
  LogService.success(
    Translation(LocaleKeys.sucess_route_created).trArgs([nameRoute]),
  );
  addNavigation(nameRoute);
}

List<String> _routesSort(List<String> lines) {
  var routes = <String>[];
  var lines2 = <String>[];
  lines2.addAll(lines);
  for (var line in lines2) {
    if (line.contains('static const')) {
      routes.add(line);
      lines.remove(line);
    }
  }
  routes.sort();
  lines.insertAll(lines.length - 1, routes);
  return lines;
}
