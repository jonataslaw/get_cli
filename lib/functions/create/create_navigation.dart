import 'dart:io';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/samples/impl/arc_navigation.dart';
import 'package:recase/recase.dart';
import '../../models/file_model.dart';

Future<void> createNavigation() async {
  FileModel _fileModel = Structure.model('', 'navigation', false);

  ReCase reCase = ReCase(_fileModel.name);

  File _route =
      await File((_fileModel.path + "navigation.dart")).create(recursive: true);
  await _route.writeAsString(ArcNavigationSample().file(reCase.pascalCase));

  LogService.success("Navigation created succesfully.");
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

  lines.insert(lines.length - 2, '    GetPage(');
  lines.insert(
      lines.length - 2, '    name: Routes.${name.snakeCase.toUpperCase()},');
  lines.insert(lines.length - 2, '    page: () => ${name.pascalCase}Screen(),');
  lines.insert(
      lines.length - 2, '    binding: ${name.pascalCase}ControllerBinding()');
  lines.insert(lines.length - 2, '  ),');
  lines.insert(0,
      '''import '../../presentation/${name.snakeCase}/${name.snakeCase}.screen.dart';''');
  lines.insert(0,
      '''import '../../infrastructure/navigation/bindings/controllers/${name.snakeCase}.controller.binding.dart';''');

  await navigationFile.writeAsStringSync(lines.join('\n'));
  LogService.success("${name.pascalCase} navigation add succesfully.");
}
