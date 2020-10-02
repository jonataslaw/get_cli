import 'package:get_cli/commands/impl/create/create.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/samples/impl/get_view.dart';
import 'package:recase/recase.dart';

class CreateViewCommand extends Command with CreateMixin {
  @override
  String get hint => 'generate view';

  @override
  bool validate() {
    return true;
  }

  @override
  Future<void> execute() async {
    await handleFileCreate(
        name,
        'view',
        onCommand,
        true,
        GetViewSample(
          '',
          name.pascalCase + 'View',
          null,
          null,
          PubspecUtils.isServerProject,
        ),
        'views');
  }
}
