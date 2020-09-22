import 'dart:io';

import 'package:cli_menu/cli_menu.dart';
import 'package:get_cli/commands/impl/create/create.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/core/generator.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/routes/get_add_route.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/get_binding.dart';
import 'package:get_cli/samples/impl/get_controller.dart';
import 'package:get_cli/samples/impl/get_view.dart';
import 'package:recase/recase.dart';

class CreatePageCommand extends Command with CreateMixin {
  @override
  Future<void> execute() async {
    bool isProject = false;
    if (GetCli.arguments[0] == 'create') {
      isProject = GetCli.arguments[1].split(':').first == 'project';
    }
    FileModel _fileModel =
        Structure.model(isProject ? 'home' : name, 'page', true, on: onCommand);
    if (File(_fileModel.path + '_view.dart').existsSync() ||
        File(_fileModel.path + '_binding.dart').existsSync() ||
        File(_fileModel.path + '_controller.dart').existsSync()) {
      LogService.info(
          'The page [$name] already exists, do you want to overwrite it?');
      final menu = Menu(['Yes', 'No']);
      final result = menu.choose();
      if (result.index == 0) {
        await _writeFiles(_fileModel, isProject ? 'home' : name,
            overwrite: true);
      }
    } else {
      await _writeFiles(_fileModel, isProject ? 'home' : name,
          overwrite: false);
    }
  }

  @override
  String get hint => 'Use to generate pages';

  @override
  bool validate() {
    return true;
  }

  Future<void> _writeFiles(FileModel _fileModel, String name,
      {bool overwrite = false}) async {
    List<String> pathSplit = _fileModel.path.replaceAll('\\', '/').split('/');
    pathSplit.remove('.');
    pathSplit.remove('lib');
    String path = pathSplit.join('/');
    print(path);

    String controllerDir = path + '_controller.dart';

    bool isServer = PubspecUtils.isServerProject;

    await ControllerSample(
      _fileModel.path + '_controller.dart',
      name,
      isServer,
      overwrite: overwrite,
    ).create();

    await BindingSample(
      _fileModel.path + '_binding.dart',
      name,
      name.pascalCase + 'Binding',
      controllerDir,
      isServer,
      overwrite: overwrite,
    ).create();

    await GetViewSample(
            _fileModel.path + '_view.dart',
            name.pascalCase + 'View',
            name.pascalCase + 'Controller',
            controllerDir,
            isServer,
            overwrite: overwrite)
        .create();

    await addRoute(name, path);
    LogService.success(name.pascalCase + ' page created successfully.');
    return;
  }
}
