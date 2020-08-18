import 'dart:io';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/get_main.dart';
import 'package:get_cli/core/structure.dart';
import 'package:recase/recase.dart';

Future<void> createMain() async {
  FileModel _fileModel = FileModel(
    result: '',
    path: Structure.getPathWithName(
      defaultStructure.getPathByKey('init'),
      '',
      createWithWrappedFolder: false,
    ),
    commandName: 'init',
  );
  ReCase reCase = ReCase(_fileModel.result);

  File _route = await File(_fileModel.path + "main.dart");

  if (!_route.existsSync()) {
    _route.create(recursive: true);
  }

  await _route.writeAsString(GetMainSample().file(reCase.pascalCase));
  print(reCase.pascalCase + " Main created succesfully.");
}
