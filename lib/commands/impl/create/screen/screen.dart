import 'package:get_cli/commands/impl/create/create.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/core/generator.dart';
import 'package:get_cli/functions/exports_files/add_export.dart';
import 'package:get_cli/functions/routes/arc_add_route.dart';
import 'package:get_cli/samples/impl/get_binding.dart';
import 'package:get_cli/samples/impl/get_controller.dart';
import 'package:get_cli/samples/impl/get_view.dart';
import 'package:recase/recase.dart';

class CreateScreenCommand extends Command with CreateMixin {
  @override
  Future<void> execute() async {
    bool isProject = false;
    if (GetCli.arguments[0] == 'create') {
      isProject = GetCli.arguments[1].split(':').first == 'project';
    }
    String name = isProject ? 'home' : this.name;

    String baseFolder = 'lib/presentation/';
    String screenDir = '${name.snakeCase}/${name.snakeCase}.screen.dart';
    String controllerDir =
        'presentation/${name.snakeCase}/controllers/${name.snakeCase}.controller.dart';
    String bindingDir =
        'lib/infrastructure/navigation/bindings/controllers/${name.snakeCase}.controller.binding.dart';

    await GetViewSample('$baseFolder/$screenDir', '${name.pascalCase}Screen',
            '${name.pascalCase}Controller', controllerDir)
        .create();

    await addExport('lib/presentation/screens.dart', 'export \'$screenDir\';');
    await BindingSample(bindingDir, name, '${name.pascalCase}ControllerBinding',
            controllerDir)
        .create();
    await addExport(
        'lib/infrastructure/navigation/bindings/controllers/controllers_bindings.dart',
        '''export '${name.snakeCase}.controller.binding.dart';''');

    await ControllerSample('lib/$controllerDir', name).create();

    await arcAddRoute(name);
  }

  @override
  String get hint => 'Generate new screen';

  @override
  bool validate() {
    return true;
  }
}
