import 'dart:io';

import 'package:get_cli/common/default_file_creator.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/interface/sample_interface.dart';
import 'package:recase/recase.dart';

Future handleFileCreate(String name, String command, String on,
    bool extraFolder, Sample sample) async {
  Generator defaultGenerator = Generator(currentStructure: defaultStructure);

  FileModel _fileModel = FileModel(
    result: '',
    path: Structure.getPathWithName(
      defaultStructure.getPathByKey('init'),
      '',
      createWithWrappedFolder: false,
    ),
    commandName: 'init',
  );

  Directory current = Directory(_fileModel.path);

  final list = current.listSync(recursive: true, followLinks: false);

  final contains = list.firstWhere((element) => element.path.contains(on),
      orElse: () => null);

  await defaultGenerator.createFile(
      fileModel: FileModel(
        result: name,
        path: Structure.getPathWithName(
          (on != null) ? contains.path : defaultStructure.getPathByKey(command),
          ReCase(name).snakeCase,
          createWithWrappedFolder: extraFolder,
        ),
        commandName: command,
      ),
      content: sample);
}
