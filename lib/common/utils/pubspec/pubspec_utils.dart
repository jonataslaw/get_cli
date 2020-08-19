import 'dart:io';
import 'package:get_cli/common/utils/pub_dev/pub_dev_api.dart';

class PubspecUtils {
  static void addDependencies(String package, {String version}) async {
    var pubspec = File('pubspec.yaml');
    var lines = pubspec.readAsLinesSync();
    var index =
        lines.indexWhere((element) => element.trim() == 'dev_dependencies:');
    while (lines[index - 1].isEmpty) {
      index--;
    }
    version = version == null || version.isEmpty
        ? await PubDevApi.getLatestVersionFromPackage(package)
        : '^$version';
    lines.insert(index, '  $package: $version');
    await pubspec.writeAsStringSync(lines.join('\n'));
  }

  static void removeDependencies(String package) async {
    var pubspec = File('pubspec.yaml');
    var lines = pubspec.readAsLinesSync();
    var index = lines
        .indexWhere((element) => element.split(':').first.trim() == package);
    lines.removeAt(index);
    await pubspec.writeAsStringSync(lines.join('\n'));
  }
}
