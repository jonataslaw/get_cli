import 'package:get_cli/commands/impl/args_mixin.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:get_cli/functions/binding/add_dependencies.dart';
import 'package:get_cli/functions/binding/find_bindings.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/samples/impl/get_controller.dart';
import 'package:path/path.dart';

class CreateControllerCommand extends Command with ArgsMixin {
  @override
  String get hint => 'generate controller';

  @override
  bool validate() {
    return true;
  }

  @override
  Future<void> execute() async {
    String path = await handleFileCreate(
      name,
      'controller',
      onCommand,
      true,
      ControllerSample('', name, PubspecUtils.isServerProject),
      'controllers',
    );

    String binindingPath = findBindingFromName(path, basename(onCommand));
    List<String> pathSplit = Structure.safeSplitPath(path);
    pathSplit.remove('.');
    pathSplit.remove('lib');
    if (binindingPath != '') {
      addDependencieToBinding(binindingPath, name, pathSplit.join('/'));
    }
  }
}
