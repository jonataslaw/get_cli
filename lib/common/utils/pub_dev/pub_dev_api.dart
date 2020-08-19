import 'package:html/parser.dart';
import 'package:http/http.dart';

class PubDevApi {
  //Find latest version in the Pub Dev.
  static Future<String> getLatestVersionFromPackage(String package) async {
    var res = await get('https://pub.dev/packages/$package/install');
    var document = parse(res.body);
    var divElement =
        document.getElementsByClassName('language-yaml').first.text;
    var packageDetails = divElement.split(':');

    return packageDetails.last.trim();
  }
}
