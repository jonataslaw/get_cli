import 'dart:io';

import 'package:cli_menu/cli_menu.dart';

import '../../common/utils/logger/log_utils.dart';
import '../../core/internationalization.dart';
import '../../core/locales.g.dart';
import '../../core/structure.dart';

Future<bool> createMain() async {
  var _fileModel = Structure.model('', 'init', false);

  var _main = File('${_fileModel.path}main.dart');

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
