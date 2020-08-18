import 'dart:io';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_controller.dart';
import 'package:get_cli/functions/create/create_view.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/get_binding.dart';
import 'package:recase/recase.dart';

Future<void> createPage([String name = 'home']) async {
  String modelType = 'page';

  FileModel _fileModel = FileModel(
    result: name,
    path: Structure.getPathWithName(
      defaultStructure.getPathByKey(modelType),
      ReCase(name).snakeCase,
      createWithWrappedFolder: true,
    ),
    commandName: modelType,
  );
  ReCase reCase = ReCase(_fileModel.result);

  await createView(name, defaultStructure.getPathByKey(modelType));
  await createController(name, defaultStructure.getPathByKey(modelType));

  ///TODO criar uma função "createBinding" pros bindings,
  ///igual as funções abaixo de view e controller
  File _binding =
      await File(_fileModel.path + "_binding.dart").create(recursive: true);
  await _binding.writeAsString(BindingSample().file(reCase.pascalCase));
  // File _view =
  //     await File(_fileModel.path + "_view.dart").create(recursive: true);
  // await _view.writeAsString(GetViewSample().file(reCase.pascalCase));
  // File _controller =
  //     await File(_fileModel.path + "_controller.dart").create(recursive: true);
  // await _controller.writeAsString(ControllerSample().file(reCase.pascalCase));

  print(reCase.pascalCase + " Page created succesfully.");
}
