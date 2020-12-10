import 'dart:developer';
import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:get_cli/common/utils/json_serialize/model_generator.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/samples/interface/sample_interface.dart';
import 'package:path/path.dart';

import '../../core/structure.dart';

Future handleFileCreate(String name, String command, String on,
    bool extraFolder, Sample sample, String folderName) async {
  final fileModel = Structure.model(name, command, extraFolder,
      on: on, folderName: folderName);
  print(fileModel.path);
  String path = fileModel.path + '_${fileModel.commandName}.dart';
  sample.path = path;
  await sample.create();
  print(
      'File "${fileModel.name}" created successfully at path: ${fileModel.path}');
  return sample.path;
}

Future<void> writeFile(String path, String content,
    {bool overwrite = false, bool skipFormatter = false}) async {
  File _file = await File(Structure.replaceAsExpected(path: path));
  print('salvado file ' + basename(path) + ' $skipFormatter');
  if (!await _file.exists() || overwrite) {
    await _file.create(recursive: true);
    if (!skipFormatter) {
      if (path.endsWith('.dart')) {
        try {
          DartFormatter formatter = DartFormatter();
          content = formatter.format(content);
        } catch (e) {
          LogService.info('invalid dart file format in $path file');
          rethrow;
        }
      }
    }

    await _file.writeAsString(content);

    LogService.success(basename(path) + ' created');
  }
}
