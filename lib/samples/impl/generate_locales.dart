import 'package:get_cli/samples/interface/sample_interface.dart';

class GenerateLocalesSample extends Sample {
  final String _translationsKeys;
  final String _keys;
  final String _locales;
  GenerateLocalesSample(this._keys, this._locales, this._translationsKeys)
      : super('lib/generated/locales.g.dart', overwrite: true);

  @override
  Future<String> get content async => '''
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class AppTranslation {

  static Map<String, Map<String, String>> translations = {
$_translationsKeys
  };

}
abstract class LocaleKeys {
$_keys
}

abstract class Locales {
  $_locales
}
''';
}
