import 'dart:io';

import 'package:get_cli/models/get_route.dart';
import 'package:recase/recase.dart';

import '../file_model.dart';
import '../get_cli.dart';

Future<void> createRoute() async {
  FileModel _fileModel = FileModel(
    result: '',
    path: Structure.getPathWithName(
      defaultStructure.getPathByKey('route'),
      '',
      createWithWrappedFolder: false,
    ),
    commandName: 'route',
  );
  ReCase reCase = ReCase(_fileModel.result);

  File _route =
      await File(_fileModel.path + "route.dart").create(recursive: true);
  await _route.writeAsString(RouteSample().file(reCase.pascalCase));

  print(reCase.pascalCase + " Page created succesfully.");
}
