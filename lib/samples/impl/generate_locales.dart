import 'package:get_cli/samples/interface/sample_interface.dart';

class GenerateLocalesSample extends Sample {
  String translationsKeys;
  String keys;
  String locales;
  GenerateLocalesSample(this.keys, this.locales, this.translationsKeys)
      : super('lib/generated/locales.g.dart', overwrite: true);

  @override
  Future<String> get content async => '''
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class AppTranslation {

  static Map<String, Map<String, String>> translations = {
$translationsKeys
  };

}
abstract class LocaleKeys {
$keys
}

abstract class Locales {
  $locales
}
''';
}
