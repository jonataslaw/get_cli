import 'dart:convert';
import 'dart:io';

import 'package:recase/recase.dart';

import '../../common/utils/logger/log_utils.dart';
import '../../core/internationalization.dart';
import '../../core/locales.g.dart';
import '../../core/structure.dart';
import '../../samples/impl/arctekko/arc_navigation.dart';
import '../formatter_dart_file/formatter_dart_file.dart';
import 'create_single_file.dart';

void createNavigation() {
  ArcNavigationSample().create(skipFormatter: true);
}

void addNavigation(String name) {
  var navigationFile = File(Structure.replaceAsExpected(
      path: 'lib/infrastructure/navigation/navigation.dart'));

  List<String> lines;

  if (!navigationFile.existsSync()) {
    createNavigation();
    lines = navigationFile.readAsLinesSync();
  } else {
    var content = formatterDartFile(navigationFile.readAsStringSync());
    lines = LineSplitter.split(content).toList();
  }
  navigationFile.readAsLinesSync();

  while (lines.last.isEmpty) {
    lines.removeLast();
  }

  var indexStartNavClass = lines.indexWhere(
    (line) => line.contains('class Nav'),
  );
  var index =
      lines.indexWhere((element) => element.contains('];'), indexStartNavClass);

  lines.insert(index, '''    GetPage(
      name: Routes.${name.snakeCase.toUpperCase()},
      page: () => ${name.pascalCase}Screen(),
      binding: ${name.pascalCase}ControllerBinding(),
    ),    ''');

  writeFile(navigationFile.path, lines.join('\n'),
      overwrite: true, logger: false);

  LogService.success(Translation(
      LocaleKeys.success_navigation_added.trArgs([name.pascalCase])));
}
