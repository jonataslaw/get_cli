import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../../functions/create/create_single_file.dart';
import '../../../../samples/impl/get_provider.dart';
import '../../../interface/command.dart';
import '../../args_mixin.dart';

class CreateProviderCommand extends Command with ArgsMixin {
  @override
  String get commandName => 'provider';
  @override
  Future<void> execute() async {
    await handleFileCreate(name, 'provider', onCommand, onCommand != null,
        ProviderSample(name), 'providers');
  }

  @override
  String get hint => Translation(LocaleKeys.hint_create_provider).tr;

  @override
  bool validate() {
    return true;
  }
}
