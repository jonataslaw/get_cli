import 'dart:io';

import 'package:get_cli/common/menu/menu.dart';
import 'package:get_cli/common/utils/logger/log_utils.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:get_cli/core/structure.dart';

Future<bool> createMain() async {
  var newFileModel = Structure.model('', 'init', false);

  var main = File('${newFileModel.path}main.dart');

  if (main.existsSync()) {
    /// apenas quem chama essa função é o create project e o init,
    /// ambas funções iniciam um projeto e sobrescreve os arquivos

    final menu = Menu(
      [LocaleKeys.options_yes.tr, LocaleKeys.options_no.tr],
      title: LocaleKeys.ask_lib_not_empty.tr,
    );
    final result = menu.choose();
    if (result.index == 1) {
      LogService.info(LocaleKeys.info_no_file_overwritten.tr);
      return false;
    }
    await Directory('lib/').delete(recursive: true);
  }
  return true;
}
