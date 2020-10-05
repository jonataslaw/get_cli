import 'dart:io';

import 'package:cli_menu/cli_menu.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/models/file_model.dart';
import '../../common/utils/logger/LogUtils.dart';
import '../../core/structure.dart';

Future<bool> createMain() async {
  FileModel _fileModel = Structure.model('', 'init', false);

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
    await Directory('lib/').delete(recursive: true);
  }
  LogService.success('Main sample created successfully 👍');
  return true;
}
