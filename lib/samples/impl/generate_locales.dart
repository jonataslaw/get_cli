import 'package:get_cli/samples/interface/sample_interface.dart';

class GenerateLocalesSample extends Sample {
  @override
  String file(String filename,
      {String keys, String locales, String translationsKeys}) {
    return '''
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class AppTranslation {

  static Map<String, Map<String, String>> translations = {
    $translationsKeys
  };

}
abstract class LocaleKeys {
${keys}
}

abstract class Locales {
  ${locales}
}
''';
  }
}
