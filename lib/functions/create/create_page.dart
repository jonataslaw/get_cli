import 'dart:io';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/get_binding.dart';
import 'package:recase/recase.dart';

import '../../core/structure.dart';
import '../../samples/impl/get_controller.dart';
import '../../samples/impl/get_view.dart';

Future<void> createPage([String name = 'home']) async {
  FileModel _fileModel = Structure.model(name, 'page', true);

  ReCase reCase = ReCase(_fileModel.name);

  File _binding =
      await File(_fileModel.path + "_binding.dart").create(recursive: true);
  await _binding.writeAsString(BindingSample().file(reCase.pascalCase));
  File _view =
      await File(_fileModel.path + "_view.dart").create(recursive: true);
  await _view.writeAsString(GetViewSample().file(reCase.pascalCase));
  File _controller =
      await File(_fileModel.path + "_controller.dart").create(recursive: true);
  await _controller.writeAsString(ControllerSample().file(reCase.pascalCase));

  print(reCase.pascalCase + " Page created succesfully.");
}
