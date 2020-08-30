import 'dart:io';

import 'package:get_cli/core/structure.dart';
import 'package:get_cli/samples/impl/get_controller.dart';
import 'package:recase/recase.dart';

import '../../core/structure.dart';
import '../../models/file_model.dart';

Future<void> createController(String name, String path) async {
  FileModel _fileModel = Structure.model(name, 'controller', true);

  ReCase reCase = ReCase(_fileModel.name);

  File _view = await File((_fileModel.path) + "_controller.dart")
      .create(recursive: true);
  await _view.writeAsString(ControllerSample().file(reCase.pascalCase));

  print(reCase.pascalCase + " controller created successfully.");
}
