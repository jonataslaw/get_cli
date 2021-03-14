import 'dart:convert';

import 'package:http/http.dart';

import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../logger/log_utils.dart';

class PubDevApi {
  static Future<String> getLatestVersionFromPackage(String package) async {
    var res = await get('https://pub.dev/api/packages/$package').then((value) {
      if (value.statusCode == 200) {
        return json.decode(value.body)['latest']['version'];
      } else if (value.statusCode == 404) {
        LogService.info(
          LocaleKeys.error_package_not_found.trArgs([package]),
          false,
          false,
        );
      }
      return null;
    });

    return res as String;
  }
}
