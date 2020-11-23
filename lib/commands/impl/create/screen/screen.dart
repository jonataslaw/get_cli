import 'package:get_cli/commands/impl/args_mixin.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/core/generator.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/exports_files/add_export.dart';
import 'package:get_cli/functions/routes/arc_add_route.dart';
import 'package:get_cli/models/file_model.dart';
import 'package:get_cli/samples/impl/get_binding.dart';
import 'package:get_cli/samples/impl/get_controller.dart';
import 'package:get_cli/samples/impl/get_view.dart';
import 'package:recase/recase.dart';

class CreateScreenCommand extends Command with ArgsMixin {
  @override
  Future<void> execute() async {
    bool isProject = false;
    if (GetCli.arguments[0] == 'create') {
      isProject = GetCli.arguments[1].split(':').first == 'project';
    }
    String name = isProject ? 'home' : this.name;

    FileModel _fileModel =
        Structure.model('', 'screen', true, on: onCommand, folderName: name);

    String screenDir = _fileModel.path + '${name.snakeCase}.screen.dart';
    List<String> pathScreenSplit = Structure.safeSplitPath(screenDir);
    pathScreenSplit.removeWhere((element) =>
        element == '.' || element == 'lib' || element == 'presentation');

    String screenImport = pathScreenSplit.join('/');
    String controllerDir =
        '${_fileModel.path}controllers/${name.snakeCase}.controller.dart';

    List<String> pathControllerSplit = Structure.safeSplitPath(controllerDir);
    pathControllerSplit
        .removeWhere((element) => element == '.' || element == 'lib');
    String controllerImport = pathControllerSplit.join('/');

    String bindingDir =
        'lib/infrastructure/navigation/bindings/controllers/${name.snakeCase}.controller.binding.dart';

    bool isServer = PubspecUtils.isServerProject;
    print(_fileModel.path);

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
        '''export '${name.snakeCase}.controller.binding.dart';''');

    await ControllerSample('$controllerDir', name, isServer).create();

    await arcAddRoute(name);
  }

  @override
  String get hint => 'Generate new screen';

  @override
  bool validate() {
    return true;
  }
}
