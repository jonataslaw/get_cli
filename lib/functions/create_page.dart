import 'dart:io';
import 'package:args/args.dart';
import 'package:get_cli/get_cli.dart';
import 'package:get_cli/models/get_binding.dart';
import 'package:get_cli/models/get_controller.dart';
import 'package:get_cli/models/get_view.dart';
import 'package:recase/recase.dart';

Future<void> createPage([ArgResults results]) async {
  FileModel _fileModel = FileModel(
    result: results == null ? 'home' : results['name'],
    path: Structure.getPathWithName(
      defaultStructure.getPathByKey('page'),
      ReCase(results == null ? 'home' : results['name']).snakeCase,
      createWithWrappedFolder: true,
    ),
    commandName: results == null ? 'home' : results.command.name,
  );
  ReCase reCase = ReCase(_fileModel.result);

  /// Create module of files
  File _controller =
      await File(_fileModel.path + "_controller.dart").create(recursive: true);
  await _controller.writeAsString(ControllerSample().file(reCase.pascalCase));
  File _binding =
      await File(_fileModel.path + "_binding.dart").create(recursive: true);

  await _binding.writeAsString(BindingSample().file(reCase.pascalCase));

  File _view =
      await File(_fileModel.path + "_view.dart").create(recursive: true);
  await _view.writeAsString(GetViewSample().file(reCase.pascalCase));

  print(reCase.pascalCase + " Page created succesfully.");
}
