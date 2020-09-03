import 'dart:io';

import 'package:cli_menu/cli_menu.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/get_main.dart';
import 'package:recase/recase.dart';

import '../../common/utils/logger/LogUtils.dart';
import '../../core/structure.dart';

Future<bool> createMain({bool isArc = false}) async {
  FileModel _fileModel = Structure.model('', 'init', false);

  ReCase reCase = ReCase(_fileModel.name);

  File _main = await File(_fileModel.path + 'main.dart');

  if (_main.existsSync()) {
    /// apenas quem chama essa função é o create project e o init,
    /// ambas funções iniciam um projeto e sobrescreve os arquivos
    LogService.info(
        '''Your lib folder is not empty. Are you sure you want to overwrite your project?
WARNING: This action is irreversible''');
    final menu = Menu(['Yes', 'No']);
    final result = menu.choose();
    if (result.index == 1) {
      LogService.info('No files were overwritten');
      return false;
    }
  }
  await _main.create(recursive: true);
  await _main.writeAsString(MainSample().file(reCase.pascalCase, isArc: isArc));
  LogService.success('Main sample created successfully 👍');
  return true;
}
