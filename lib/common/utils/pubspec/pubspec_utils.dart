import 'dart:io';

import 'package:cli_menu/cli_menu.dart';
import 'package:get_cli/core/internationalization.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:version/version.dart';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pub_dev/pub_dev_api.dart';
import 'package:get_cli/common/utils/shell/shel.utils.dart';
import 'package:get_cli/exception_handler/exceptions/cli_exception.dart';
import 'package:yaml/yaml.dart';

class PubspecUtils {
  static final _pubspec = File('pubspec.yaml');
  static final Map<String, dynamic> _mapSep = {
    'separator': '',
    'isChecked': false
  };
  static final Map<String, dynamic> _mapName = {'name': '', 'isChecked': false};

  static String _getProjectName() {
    _mapName['isChecked'] = true;
    var lines = _pubspec.readAsLinesSync();
    String name = lines
        .firstWhere((line) => line.startsWith('name:'), orElse: () => null)
        ?.split(':')
        ?.last
        ?.trim();
    return name;
  }

  static String getProjectName() {
    if (!_mapName['isChecked']) {
      _mapName['name'] = _getProjectName();
    }
    return _mapName['name'];
  }

  static Future<bool> addDependencies(String package,
      {String version, bool isDev = false, bool runPubGet = true}) async {
    var lines = _pubspec.readAsLinesSync();
    if (containsPackage(package)) {
      print(Translation(LocaleKeys.ask_package_already_installed)
          .trArgs([package]));
      final menu = Menu([
        LocaleKeys.options_yes.tr,
        LocaleKeys.options_no.tr,
      ]);
      final result = menu.choose();
      if (result.index != 0) {
        return false;
      }
    }
    lines.removeWhere((element) => element.startsWith('  $package:'));
    var index = isDev
        ? lines.indexWhere((element) => element.trim() == 'dev_dependencies:')
        : lines.indexWhere((element) => element.trim() == 'dependencies:');
    index++;
    version = version == null || version.isEmpty
        ? await PubDevApi.getLatestVersionFromPackage(package)
        : '^$version';
    if (version == null) return false;
    lines.insert(index, '  $package: $version');
    _pubspec.writeAsStringSync(lines.join('\n'));
    if (runPubGet) await ShellUtils.pubGet();
    LogService.success(LocaleKeys.sucess_package_installed.trArgs([package]));
    return true;
  }

  static void removeDependencies(String package, {bool logger = true}) async {
    if (logger) LogService.info('Removing package: "$package"');

    var lines = _pubspec.readAsLinesSync();
    if (containsPackage(package)) {
      lines.removeWhere((element) => element.startsWith('  $package:'));
      _pubspec.writeAsStringSync(lines.join('\n'));
      if (logger) {
        LogService.success(LocaleKeys.sucess_package_removed.trArgs([package]));
      }
    } else if (logger) {
      LogService.info(LocaleKeys.info_package_not_installed.trArgs([package]));
    }
  }

  static bool containsPackage(String package) {
    var lines = _pubspec.readAsLinesSync();

    int i = lines.indexWhere((element) => element.startsWith('  $package:'));
    return i != -1;
  }

  static bool get isServerProject {
    // LogService.info('Checking project type');

    var lines = _pubspec.readAsLinesSync();
    final serverLine = lines.firstWhere(
        (element) => element.split(':').first.trim() == 'get_server',
        orElse: () => '');

    if (serverLine.isEmpty) {
      // LogService.info('Flutter project detected!');
      return false;
    } else {
      //LogService.info('Get Server project detected!');
      return true;
    }
  }

  static String get getPackageImport => !isServerProject
      ? "import 'package:get/get.dart';"
      : "import 'package:get_server/get_server.dart';";

  static Version getPackageVersion(String package) {
    var lines = _pubspec.readAsLinesSync();
    int index =
        lines.indexWhere((element) => element.startsWith('  $package:'));
    if (index != -1) {
      Version version = Version.parse(lines[index].split(':').last.trim());
      return version;
    } else {
      throw CliException(
          LocaleKeys.info_package_not_installed.trArgs([package]));
    }
  }

  static String get separatorFileType {
    if (!_mapSep['isChecked']) {
      _mapSep['separator'] = _separatorFileType;
    }
    return _mapSep['separator'];
  }

  static String get _separatorFileType {
    _mapSep['isChecked'] = true;
    YamlMap yaml = loadYaml(_pubspec.readAsStringSync());
    if (yaml.containsKey('get_cli')) {
      if (yaml['get_cli'].containsKey('separator')) {
        return yaml['get_cli']['separator'] ?? '';
      }
    }

    return '';
  }
}
