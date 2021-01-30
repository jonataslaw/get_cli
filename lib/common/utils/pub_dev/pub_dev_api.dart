import 'dart:convert';

import 'package:http/http.dart';

import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../logger/log_utils.dart';

class PubDevApi {
  //Find latest version in the Pub Dev.
  /* static Future<String> getLatestVersionFromPackage(String package) async {
    var res = await get('https://pub.dev/packages/$package/install');
    var document = parse(res.body);
    var divElement =
        document.getElementsByClassName('language-yaml').first.text;
    var packageDetails = divElement.split(':');

    return packageDetails.last.trim();
  } */

  static Future<String> getLatestVersionFromPackage(String package) async {
    var res = await get('https://pub.dev/api/packages/$package').then((value) {
      if (value.statusCode == 200) {
        return json.decode(value.body)['latest']['version'];
      } else if (value.statusCode == 404) {
        LogService.info(Translation(LocaleKeys.error_package_not_found).tr);
      }
      return null;
    });

    return res as String;
  }
}
