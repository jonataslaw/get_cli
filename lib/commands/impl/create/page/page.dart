import 'dart:io';

import 'package:cli_menu/cli_menu.dart';
import 'package:recase/recase.dart';

import '../../../../common/utils/logger/log_utils.dart';
import '../../../../common/utils/pubspec/pubspec_utils.dart';
import '../../../../core/generator.dart';
import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../../core/structure.dart';
import '../../../../functions/create/create_single_file.dart';
import '../../../../functions/routes/get_add_route.dart';
import '../../../../samples/impl/get_binding.dart';
import '../../../../samples/impl/get_controller.dart';
import '../../../../samples/impl/get_view.dart';
import '../../../interface/command.dart';

/// The command create a Binding and Controller page and view
class CreatePageCommand extends Command {
  @override
  String get commandName => 'page';

  @override
  List<String> get alias => ['module'];
  @override
  Future<void> execute() async {
    var isProject = false;
    if (GetCli.arguments[0] == 'create') {
      isProject = GetCli.arguments[1].split(':').first == 'project';
    }
    var _fileModel = Structure.model(isProject ? 'home' : name, 'page', true,
        on: onCommand, folderName: isProject ? 'home' : name);
    var pathSplit = Structure.safeSplitPath(_fileModel.path);

    pathSplit.removeLast();
    var path = pathSplit.join('/');
    path = Structure.replaceAsExpected(path: path);
    if (Directory(path).existsSync()) {
      LogService.info(Translation(LocaleKeys.ask_existing_page.trArgs([name])));
      final menu = Menu([
        LocaleKeys.options_yes.tr,
        LocaleKeys.options_no.tr,
      ]);
      final result = menu.choose();
      if (result.index == 0) {
        await _writeFiles(path, isProject ? 'home' : name, overwrite: true);
      }
    } else {
      Directory(path).createSync(recursive: true);
      await _writeFiles(path, isProject ? 'home' : name, overwrite: false);
    }
  }

  @override
  String get hint => LocaleKeys.hint_create_page.tr;

  @override
  bool validate() {
    return true;
  }

  Future<void> _writeFiles(String path, String name,
      {bool overwrite = false}) async {
    var isServer = PubspecUtils.isServerProject;
    var extraFolder = PubspecUtils.extraFolder ?? true;
    var controllerFile = handleFileCreate(
      name,
      'controller',
      path,
      extraFolder,
      ControllerSample('', name, isServer),
      'controllers',
    );
    var controllerDir = Structure.pathToDirImport(controllerFile.path);
    var viewFile = handleFileCreate(
      name,
      'view',
      path,
      extraFolder,
      GetViewSample('', '${name.pascalCase}View',
          '${name.pascalCase}Controller', controllerDir, isServer),
      'views',
    );
    var bindingFile = handleFileCreate(
      name,
      'binding',
      path,
      extraFolder,
      BindingSample(
        '',
        name,
        '${name.pascalCase}Binding',
        controllerDir,
        isServer,
        overwrite: overwrite,
      ),
      'bindings',
    );

    addRoute(
      name,
      Structure.pathToDirImport(bindingFile.path),
      Structure.pathToDirImport(viewFile.path),
    );
    LogService.success(LocaleKeys.sucess_page_create.trArgs([name.pascalCase]));
    return;
  }
}
