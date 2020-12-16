import 'dart:io';

import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:path/path.dart';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/sorter_imports/sort.dart';
import 'package:get_cli/samples/interface/sample_interface.dart';
import '../../core/structure.dart';

File handleFileCreate(String name, String command, String on, bool extraFolder,
    Sample sample, String folderName,
    [sep = '_']) {
  final fileModel = Structure.model(name, command, extraFolder,
      on: on, folderName: folderName);
  String path = fileModel.path + '$sep${fileModel.commandName}.dart';
  sample.path = path;
  return sample.create();
}

File writeFile(String path, String content,
    {bool overwrite = false, bool skipFormatter = false, logger = true}) {
  File _file = File(Structure.replaceAsExpected(path: path));
  if (!_file.existsSync() || overwrite) {
    if (!skipFormatter) {
      if (path.endsWith('.dart')) {
        try {
          content = sortImports(content, PubspecUtils.getProjectName());
        } catch (e) {
          if (_file.existsSync()) {
            LogService.info(LocaleKeys.error_invalid_dart.trArgs([_file.path]));
          }
          rethrow;
        }
      }
    }
    String separatorFileType = PubspecUtils.separatorFileType;
    if (separatorFileType.isNotEmpty) {
      _file = _file.existsSync()
          ? _file = _file
              .renameSync(replacePathTypeSeparator(path, separatorFileType))
          : File(replacePathTypeSeparator(path, separatorFileType));
    }

    _file.createSync(recursive: true);
    _file.writeAsStringSync(content);

    if (logger) {
      LogService.success(
        LocaleKeys.sucess_file_created.trArgs(
          [basename(_file.path), _file.path],
        ),
      );
    }
  }
  return _file;
}

String replacePathTypeSeparator(String path, String separator) {
  int index = path.indexOf(RegExp(r'controller.dart|model.dart|provider.dart|'
      'binding.dart|view.dart|screen.dart'));
  if (index != -1) {
    List<String> chars = path.split('');
    index--;
    chars.removeAt(index);
    chars.insert(index, separator);
    return chars.join();
  }

  return path;
}
