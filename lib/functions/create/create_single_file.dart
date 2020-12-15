import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/sorter_imports/sort.dart';
import 'package:get_cli/samples/interface/sample_interface.dart';
import 'package:path/path.dart';

import '../../core/structure.dart';

String handleFileCreate(String name, String command, String on,
    bool extraFolder, Sample sample, String folderName) {
  final fileModel = Structure.model(name, command, extraFolder,
      on: on, folderName: folderName);
  String path = fileModel.path + '_${fileModel.commandName}.dart';
  sample.path = path;
  sample.create();
  return sample.path;
}

void writeFile(String path, String content,
    {bool overwrite = false, bool skipFormatter = false, logger = true}) {
  File _file = File(Structure.replaceAsExpected(path: path));
  if (!_file.existsSync() || overwrite) {
    if (!skipFormatter) {
      if (path.endsWith('.dart')) {
        try {
          content = sortImports(content, PubspecUtils.getProjectName());
        } catch (e) {
          if (_file.existsSync()) {
            LogService.info('invalid dart file format in $path file');
          }
          rethrow;
        }
      }
    }
    _file.createSync(recursive: true);
    _file.writeAsStringSync(content);

    if (logger) {
      LogService.success(
          'File "${basename(path)}" created successfully at path: ${_file.path}');
    }
  }
}
