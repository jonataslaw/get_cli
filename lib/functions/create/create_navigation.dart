import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/functions/formatter_dart_file/frommatter_dart_file.dart';
import 'package:get_cli/samples/impl/arctekko/arc_navigation.dart';
import 'package:recase/recase.dart';

Future<void> createNavigation() async {
  await ArcNavigationSample().create(skipFormatter: true);
}

Future<void> addNavigation(String name) async {
  File navigationFile = File(Structure.replaceAsExpected(
      path: 'lib/infrastructure/navigation/navigation.dart'));
  if (!await navigationFile.exists()) {
    await createNavigation();
  } else {
    formatterDartFile(navigationFile);
  }
  var lines = await navigationFile.readAsLinesSync();

  while (lines.last.isEmpty) {
    lines.removeLast();
  }

  int indexStartNavClass = lines.indexWhere(
    (line) => line.contains('class Nav'),
  );
  int index =
      lines.indexWhere((element) => element.contains('];'), indexStartNavClass);

  lines.insert(index, '''    GetPage(
      name: Routes.${name.snakeCase.toUpperCase()},
      page: () => ${name.pascalCase}Screen(),
      binding: ${name.pascalCase}ControllerBinding(),
    ),    ''');

  await writeFile(navigationFile.path, lines.join('\n'), overwrite: true);
  LogService.success('${name.pascalCase} navigation added successfully.');
}
