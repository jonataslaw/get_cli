import 'dart:convert';

import 'package:http/http.dart';

import 'package:get_cli/common/utils/logger/LogUtils.dart';

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
        LogService.info('Package: $package not found in pub.dev');
      }
      return null;
    });

    return res;
  }
}
