import 'dart:io';

import 'package:cli_menu/cli_menu.dart';
import 'package:get_cli/commands/impl/args_mixin.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/core/generator.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/functions/routes/get_add_route.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/get_binding.dart';
import 'package:get_cli/samples/impl/get_controller.dart';
import 'package:get_cli/samples/impl/get_view.dart';
import 'package:recase/recase.dart';

class CreatePageCommand extends Command with ArgsMixin {
  @override
  Future<void> execute() async {
    bool isProject = false;
    if (GetCli.arguments[0] == 'create') {
      isProject = GetCli.arguments[1].split(':').first == 'project';
    }
    FileModel _fileModel = Structure.model(
        isProject ? 'home' : name, 'page', true,
        on: onCommand, folderName: isProject ? 'home' : name);

    List<String> pathSplit = Structure.safeSplitPath(_fileModel.path);
    pathSplit.removeLast();
    String path = pathSplit.join('/');

    if (Directory(path).existsSync()) {
      LogService.info(Translation(LocaleKeys.ask_existing_page.trArgs([name])));
      final menu = Menu([
        LocaleKeys.options_yes.tr,
        LocaleKeys.options_no.tr,
      ]);
      final result = menu.choose();
      if (result.index == 0) {
        await _writeFiles(pathSplit, isProject ? 'home' : name,
            overwrite: true);
      }
    } else {
      Directory(path).createSync(recursive: true);
      await _writeFiles(pathSplit, isProject ? 'home' : name, overwrite: false);
    }
  }

  @override
  String get hint => LocaleKeys.hint_create_page.tr;

  @override
  bool validate() {
    return true;
  }

  Future<void> _writeFiles(List<String> pathSplit, String name,
      {bool overwrite = false}) async {
    pathSplit.remove('.');
    pathSplit.remove('lib');
    String path = pathSplit.join('/');

    String controllerDir = path + '/controllers/$name' + '_controller.dart';

    bool isServer = PubspecUtils.isServerProject;

    await handleFileCreate(
      name,
      'controller',
      path,
      true,
      ControllerSample('', name, isServer),
      'controllers',
    );

    await handleFileCreate(
      name,
      'binding',
      path,
      true,
      BindingSample(
        '',
        name,
        name.pascalCase + 'Binding',
        controllerDir,
        isServer,
        overwrite: overwrite,
      ),
      'bindings',
    );

    await handleFileCreate(
      name,
      'view',
      path,
      true,
      GetViewSample('', name.pascalCase + 'View',
          name.pascalCase + 'Controller', controllerDir, isServer),
      'views',
    );

    await addRoute(name, path);
    LogService.success(LocaleKeys.sucess_page_create.trArgs([name.pascalCase]));
    return;
  }
}
