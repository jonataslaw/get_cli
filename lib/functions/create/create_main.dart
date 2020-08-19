import 'dart:io';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/get_main.dart';
import 'package:get_cli/core/structure.dart';
import 'package:recase/recase.dart';

import '../../core/structure.dart';

Future<void> createMain() async {
  FileModel _fileModel = Structure.model('', 'init', false);

  ReCase reCase = ReCase(_fileModel.name);

  File _route = await File(_fileModel.path + "main.dart");

  if (!_route.existsSync()) {
    await _route.create(recursive: true);
  }

  await _route.writeAsString(MainSample().file(reCase.pascalCase));
  print(reCase.pascalCase + " Main created succesfully.");
}
