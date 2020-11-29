import 'package:get_cli/commands/impl/args_mixin.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
import 'package:get_cli/samples/impl/get_provider.dart';

class CreateProviderCommand extends Command with ArgsMixin {
  @override
  Future<void> execute() async {
    await handleFileCreate(name, 'provider', onCommand, false,
        ProviderSample('', name, false), '');
  }

  @override
  String get hint => 'Create a new Provider';

  @override
  bool validate() {
    return true;
  }
}
