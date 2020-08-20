import 'dart:io';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/arc_binding.dart';
import 'package:get_cli/samples/impl/arc_controler.dart';
import 'package:get_cli/samples/impl/arc_screen.dart';
import 'package:recase/recase.dart';

import '../../core/structure.dart';

Future<void> createScreen([String name = 'home']) async {
  //TODO: Melhorar
  FileModel _fileModel = Structure.model(name, 'screen', true);

  ReCase reCase = ReCase(_fileModel.name);
  File _screen = File(_fileModel.path + ".screen.dart");
  // os if são para não sobrescrever caso ja exista um arquivo
  if (!await _screen.exists()) {
    await _screen.create(recursive: true);
    await _screen.writeAsString(ArcSceeenSample().file(reCase.pascalCase));
  }
  File _binding = await File(Structure.replaceAsExpected(
          path: 'lib/infrastructure/navigation/bindings/controllers/') +
      '${reCase.snakeCase}.controller.binding.dart');
  if (!await _binding.exists()) {
    await _binding.create(recursive: true);
    await _binding.writeAsString(ArcBindingsSample().file(reCase.pascalCase));
  }
  File _controller = await File(Structure.replaceAsExpected(
          path: 'lib/presentation/${reCase.snakeCase}/controllers/') +
      '${reCase.snakeCase}.controller.dart');
  if (!await _controller.exists()) {
    await _controller.create(recursive: true);
    await _controller
        .writeAsString(ArcControllerSample().file(reCase.pascalCase));
  }

  print(reCase.pascalCase + " Screen created succesfully.");
}
