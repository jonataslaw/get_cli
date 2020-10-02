import 'package:get_cli/commands/impl/create/create.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/samples/impl/get_controller.dart';

class CreateControllerCommand extends Command with CreateMixin {
  @override
  String get hint => 'generate controller';

  @override
  bool validate() {
    return true;
  }

  @override
  Future<void> execute() async {
    await handleFileCreate(name, 'controller', onCommand, true,
        ControllerSample('', name, PubspecUtils.isServerProject));
  }
}
