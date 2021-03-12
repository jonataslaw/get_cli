import 'dart:convert';
import 'dart:io';

import 'package:recase/recase.dart';

import '../../common/utils/logger/log_utils.dart';
import '../../common/utils/pubspec/pubspec_utils.dart';
import '../../core/internationalization.dart';
import '../../core/locales.g.dart';
import '../../samples/impl/get_route.dart';
import '../create/create_single_file.dart';
import '../find_file/find_file_by_name.dart';
import '../formatter_dart_file/frommatter_dart_file.dart';
import 'get_app_pages.dart';
import 'get_support_children.dart';

/// This command will create the route to the new page
void addRoute(String nameRoute, String bindingDir, String viewDir) {
  var routesFile = findFileByName('app_routes.dart');
  var lines = <String>[];

  if (routesFile.path.isEmpty) {
    RouteSample().create(skipFormatter: true);
    routesFile = File(RouteSample().path);
    lines = routesFile.readAsLinesSync();
  } else {
    var content = formatterDartFile(routesFile.readAsStringSync());
    lines = LineSplitter.split(content).toList();
  }
  var pathSplit = viewDir.split('/');

  ///remove file
  pathSplit.removeLast();

  ///remove view folder
  if (PubspecUtils.extraFolder ?? true) {
    pathSplit.removeLast();
  }

  pathSplit.removeWhere((element) => element == 'app' || element == 'modules');

  for (var i = 0; i < pathSplit.length; i++) {
    pathSplit[i] =
        pathSplit[i].snakeCase.snakeCase.toLowerCase().replaceAll('_', '-');
  }
  var route = pathSplit.join('/');

  var indexEndRoutes = lines.indexWhere((element) => element.startsWith('}'));

  var line = "static const ${nameRoute.snakeCase.toUpperCase()} = '/$route';";

  if (supportChildrenRoutes) {
    line = 'static const ${nameRoute.snakeCase.toUpperCase()} '
        '= ${_pathsToRoute(pathSplit)};';
    var indexEndPaths =
        lines.lastIndexWhere((element) => element.startsWith('}'));

    var linePath =
        "static const ${nameRoute.snakeCase.toUpperCase()} = '/${pathSplit.last}';";
    lines.insert(indexEndPaths, linePath);
  }

  if (lines.contains(line)) {
    return;
  }

  lines.insert(indexEndRoutes, line);

  writeFile(routesFile.path, lines.join('\n'), overwrite: true, logger: false);
  LogService.success(
      Translation(LocaleKeys.sucess_route_created).trArgs([nameRoute]));

  addAppPage(nameRoute, bindingDir, viewDir);
}

/// Create routes from the path
String _pathsToRoute(List<String> pathSplit) {
  var sb = StringBuffer();
  for (var e in pathSplit) {
    sb.write('_Paths.');
    sb.write(e.snakeCase.toUpperCase());
    if (e != pathSplit.last) {
      sb.write(' + ');
    }
  }
  return sb.toString();
}
