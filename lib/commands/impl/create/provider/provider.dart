import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../../functions/create/create_single_file.dart';
import '../../../../samples/impl/get_provider.dart';
import '../../../interface/command.dart';

class CreateProviderCommand extends Command {
  @override
  String get commandName => 'provider';
  @override
  Future<void> execute() async {
    handleFileCreate(name, 'provider', onCommand, onCommand != null,
        ProviderSample(name), onCommand != null ? 'providers' : '');
  }

  @override
  String get hint => Translation(LocaleKeys.hint_create_provider).tr;

  @override
  bool validate() {
    return true;
  }
}
