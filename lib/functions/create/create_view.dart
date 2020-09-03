import 'dart:io';

import 'package:get_cli/core/structure.dart';
import 'package:get_cli/samples/impl/get_view.dart';
import 'package:recase/recase.dart';

import '../../core/structure.dart';
import '../../models/file_model.dart';

Future<void> createView(String name, String path) async {
  FileModel _fileModel = Structure.model(name, 'view', true);

  ReCase reCase = ReCase(_fileModel.name);

  File _view =
      await File((_fileModel.path) + '_view.dart').create(recursive: true);
  await _view.writeAsString(GetViewSample().file(reCase.pascalCase));

  print(reCase.pascalCase + ' view created successfully.');
}
