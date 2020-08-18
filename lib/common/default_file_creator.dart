import 'dart:io';

import 'package:get_cli/core/structure.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/interface/sample_interface.dart';
import 'package:recase/recase.dart';

/// Generator takes an [Structure] object, to specify where to create .dart files
class Generator {
  final Structure currentStructure;

  Generator({
    this.currentStructure,
  }) : assert(currentStructure != null);

  /// This function only handles file creation
  Future<File> createFile({FileModel fileModel, Sample content}) async {
    var reCase = ReCase(fileModel.result);
    var _file = await File(fileModel.path + '_${fileModel.commandName}.dart')
        .create(recursive: true);
    await _file.writeAsString(content.file(reCase.pascalCase));

    print(
        'file created succesfully with name :${fileModel.result} at path: ${fileModel.path}');
    return _file;
  }
}
