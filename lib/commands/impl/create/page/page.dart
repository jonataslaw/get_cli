import 'dart:io';

import 'package:cli_menu/cli_menu.dart';
import 'package:get_cli/commands/impl/create/create.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/functions/routes/get_add_route.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/get_binding.dart';
import 'package:get_cli/samples/impl/get_controller.dart';
import 'package:get_cli/samples/impl/get_view.dart';
import 'package:recase/recase.dart';

class CreatePageCommand extends Command with CreateMixin {
  @override
  Future<void> execute() async {
    FileModel _fileModel = Structure.model(name, 'page', true);
    ReCase reCase = ReCase(_fileModel.name);

    if (File(_fileModel.path + '_view.dart').existsSync() ||
        File(_fileModel.path + '_binding.dart').existsSync() ||
        File(_fileModel.path + '_controller.dart').existsSync()) {
      LogService.info(
          'The page [$name] already exists, do you want to overwrite it?');
      final menu = Menu(['Yes', 'No']);
      final result = menu.choose();
      if (result.index == 0) {
        await _writeFiles(_fileModel, reCase, overwrite: true);
      }
    } else {
      await _writeFiles(_fileModel, reCase);
    }
  }

  @override
  String get hint => 'Use to generate pages';

  @override
  bool validate() {
    return true;
  }

  Future<void> _writeFiles(FileModel _fileModel, ReCase reCase,
      {bool overwrite = false}) async {
    await writeFile(
        _fileModel.path + '_binding.dart',
        //erro ao criar pages com nome composto
        BindingSample().file(reCase.originalText),
        overwrite: overwrite);

    await writeFile(_fileModel.path + '_view.dart',
        GetViewSample().file(reCase.originalText),
        overwrite: overwrite);

    await writeFile(_fileModel.path + '_controller.dart',
        ControllerSample().file(reCase.pascalCase),
        overwrite: overwrite);
    await addRoute(reCase.originalText);
    LogService.success(reCase.pascalCase + ' page created successfully.');
    return;
  }
}
