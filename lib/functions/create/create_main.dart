import 'dart:io';

import 'package:cli_menu/cli_menu.dart';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
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
    LogService.info(LocaleKeys.ask_lib_not_empty.tr);

    final menu = Menu([LocaleKeys.options_yes.tr, LocaleKeys.options_no.tr]);
    final result = menu.choose();
    if (result.index == 1) {
      LogService.info(LocaleKeys.info_no_file_overwritten.tr);
      return false;
    }
    await Directory('lib/').delete(recursive: true);
  }
  return true;
}
