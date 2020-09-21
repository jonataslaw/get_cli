import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pub_dev/pub_dev_api.dart';
import 'package:get_cli/common/utils/shell/shel.utils.dart';

class PubspecUtils {
  static final _pubspec = File('pubspec.yaml');

  static Future<String> getProjectName() async {
    var lines = _pubspec.readAsLinesSync();
    return lines
        .firstWhere((line) => line.startsWith('name:'))
        .split(':')
        .last
        .trim();
  }

  static void addDependencies(String package,
      {String version, bool isDev = false, bool runPubGet = true}) async {
    var lines = _pubspec.readAsLinesSync();
    // Adicione aqui tambem para não instalar uma dependência 2 vezes.
    lines.removeWhere((element) => element.split(':').first.trim() == package);
    var index = isDev
        ? lines.indexWhere((element) => element.trim() == 'dev_dependencies:')
        : lines.indexWhere((element) => element.trim() == 'dependencies:');
    index++;
    version = version == null || version.isEmpty
        ? await PubDevApi.getLatestVersionFromPackage(package)
        : '^$version';
    if (version == null) return;
    lines.insert(index, '  $package: $version');
    await _pubspec.writeAsStringSync(lines.join('\n'));
    if (runPubGet) await ShellUtils.pubGet();
    LogService.success('Package: $package installed!');
  }

  static void removeDependencies(String package) async {
    LogService.info('Removing package: "$package"');

    var lines = _pubspec.readAsLinesSync();
    /* I changed the method so that it would not give an error 
      if the dependency was not found
    */
    lines.removeWhere((element) => element.split(':').first.trim() == package);
    await _pubspec.writeAsStringSync(lines.join('\n'));
    LogService.success('Package: "$package" removed!');
  }
}
