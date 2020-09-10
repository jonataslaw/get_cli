import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/samples/impl/arctekko/arc_navigation.dart';
import 'package:recase/recase.dart';

Future<void> createNavigation() async {
  await ArcNavigationSample().create();
}

Future<void> addNavigation(String name) async {
  File navigationFile = File(Structure.replaceAsExpected(
      path: 'lib/infrastructure/navigation/navigation.dart'));
  if (!await navigationFile.exists()) {
    await createNavigation();
  }
  var lines = await navigationFile.readAsLinesSync();

  while (lines.last.isEmpty) {
    lines.removeLast();
  }
  if (lines.last.trim() != '}') {
    lines.last = lines.last.replaceAll('}', '');
    lines.add('}');
  }
  int indexStartNavClass = lines.indexWhere(
    (line) => line.contains('class Nav'),
  );
  int index =
      lines.indexWhere((element) => element.contains('];'), indexStartNavClass);
  if (lines[index].trim() != '];') {
    lines[index] = lines[index].replaceAll('];', '');
    index++;
    lines.insert(index, '  ];');
  }

  lines.insert(index, '''    GetPage(
      name: Routes.${name.snakeCase.toUpperCase()},
      page: () => ${name.pascalCase}Screen(),
      binding: ${name.pascalCase}ControllerBinding()
    ),    ''');

  await navigationFile.writeAsStringSync(lines.join('\n'));
  LogService.success('${name.pascalCase} navigation added successfully.');
}
