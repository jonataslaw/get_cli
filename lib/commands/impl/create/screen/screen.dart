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
import '../../../../functions/exports_files/add_export.dart';
import '../../../../functions/routes/arc_add_route.dart';
import '../../../../models/file_model.dart';
import '../../../../samples/impl/get_binding.dart';
import '../../../../samples/impl/get_controller.dart';
import '../../../../samples/impl/get_view.dart';
import '../../../interface/command.dart';
import '../../args_mixin.dart';

class CreateScreenCommand extends Command with ArgsMixin {
  @override
  String get commandName => 'screen';
  @override
  Future<void> execute() async {
    bool isProject = false;
    if (GetCli.arguments[0] == 'create') {
      isProject = GetCli.arguments[1].split(':').first == 'project';
    }
    String name = isProject ? 'home' : this.name;

    FileModel _fileModel =
        Structure.model('', 'screen', true, on: onCommand, folderName: name);
    List<String> pathSplit = Structure.safeSplitPath(_fileModel.path);

    String path = pathSplit.join('/');
    path = Structure.replaceAsExpected(path: path);
    if (Directory(path).existsSync()) {
      LogService.info(Translation(LocaleKeys.ask_existing_page.trArgs([name])));
      final menu = Menu([
        LocaleKeys.options_yes.tr,
        LocaleKeys.options_no.tr,
      ]);
      final result = menu.choose();
      if (result.index == 0) {
        await _writeFiles(path, name, overwrite: true);
      }
    } else {
      Directory(path).createSync(recursive: true);
      await _writeFiles(path, name);
    }

    /*  List<String> pathScreenSplit = Structure.safeSplitPath(screenDir);
    pathScreenSplit.removeWhere((element) =>
        element == '.' || element == 'lib' || element == 'presentation');

    String screenImport = pathScreenSplit.join('/');

    String controllerDir =
        '${_fileModel.path}controllers/${name.snakeCase}.controller.dart';
    controllerDir =
        ControllerSample('$controllerDir', name, isServer).create().path;

    String controllerImport = Structure.pathToDirImport(controllerDir);

    String bindingDir =
        'lib/infrastructure/navigation/bindings/controllers/${name.snakeCase}.controller.binding.dart';

    await GetViewSample(screenDir, '${name.pascalCase}Screen',
            '${name.pascalCase}Controller', controllerImport, isServer)
        .create();

    await addExport(
        'lib/presentation/screens.dart', 'export \'$screenImport\';');
    await BindingSample(bindingDir, name, '${name.pascalCase}ControllerBinding',
            controllerImport, isServer)
        .create();
    await addExport(
        'lib/infrastructure/navigation/bindings/controllers/controllers_bindings.dart',
        '''export '${name.snakeCase}.controller.binding.dart';'''); */
  }

  @override
  String get hint => Translation(LocaleKeys.hint_create_screen).tr;

  @override
  bool validate() {
    return true;
  }

  void _writeFiles(String path, String name, {bool overwrite = false}) {
    bool isServer = PubspecUtils.isServerProject;

    File controller = handleFileCreate(name, 'controller', path, true,
        ControllerSample('', name, isServer), 'controllers', '.');

    String controllerImport = Structure.pathToDirImport(controller.path);

    File view = handleFileCreate(
        name,
        'screen',
        path,
        false,
        GetViewSample(
          '',
          '${name.pascalCase}Screen',
          '${name.pascalCase}Controller',
          controllerImport,
          isServer,
        ),
        '',
        '.');
    ;
    File binding = handleFileCreate(
        name,
        'controller.binding',
        '',
        true,
        BindingSample(
          '',
          name,
          '${name.pascalCase}ControllerBinding',
          controllerImport,
          isServer,
        ),
        'controllers',
        '.');

    String exportView = 'package:' +
        PubspecUtils.getProjectName() +
        '/' +
        Structure.pathToDirImport(view.path);
    addExport('lib/presentation/screens.dart', "export '$exportView';");

    addExport(
        'lib/infrastructure/navigation/bindings/controllers/controllers_bindings.dart',
        "export 'package:${PubspecUtils.getProjectName()}/${Structure.pathToDirImport(binding.path)}'; ");
    arcAddRoute(name);
  }
}
