import 'dart:io';

import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/samples/impl/get_app_pages.dart';
import 'package:recase/recase.dart';
import '../../models/file_model.dart';

Future<void> createAppPage() async {
  FileModel _fileModel = Structure.model('', 'route', false);

  ReCase reCase = ReCase(_fileModel.name);

  await writeFile(_fileModel.path + "app_pages.dart",
      AppPagesSample().file(reCase.pascalCase));
}

Future<void> addAppPage(String name) async {
  File appPagesFile =
      File(Structure.replaceAsExpected(path: 'lib/routes/app_pages.dart'));
  if (!await appPagesFile.exists()) {
    await createAppPage();
  }
  var lines = await appPagesFile.readAsLinesSync();

  while (lines.last.isEmpty) {
    lines.removeLast();
  }
  String nameSnakeCase = name.snakeCase;
  String namePascalCase = name.pascalCase;
  String line = '''    GetPage(name: Routes.${nameSnakeCase.toUpperCase()}, 
      page:()=> ${namePascalCase}View(), 
      binding: ${namePascalCase}Binding(),
    ),''';
  lines.insert(lines.length - 2, line);
  lines.insert(
      0, '''import '../pages/$nameSnakeCase/${nameSnakeCase}_binding.dart';''');
  lines.insert(
      0, '''import '../pages/$nameSnakeCase/${nameSnakeCase}_view.dart';''');

  await appPagesFile.writeAsStringSync(lines.join('\n'));
}
