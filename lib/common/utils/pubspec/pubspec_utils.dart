import 'dart:io';

import 'package:cli_menu/cli_menu.dart';
import 'package:version/version.dart';
import 'package:yaml/yaml.dart';

import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../../../exception_handler/exceptions/cli_exception.dart';
import '../../../extensions.dart';
import '../logger/log_utils.dart';
import '../pub_dev/pub_dev_api.dart';
import '../shell/shel.utils.dart';

// ignore: avoid_classes_with_only_static_members
class PubspecUtils {
  static final _pubspec = File('pubspec.yaml');
  static final _mapSep = _PubValue<String>();
  static final _mapName = _PubValue<String>();
  static final _extraFolder = _PubValue<bool>();
  static String _getProjectName() {
    _mapName.isChecked = true;
    var lines = _pubspec.readAsLinesSync();
    var name = lines
        .firstWhere((line) => line.startsWith('name:'), orElse: () => null)
        ?.split(':')
        ?.last
        ?.trim();
    return name;
  }

  static String getProjectName() {
    if (!(_mapName.isChecked)) {
      _mapName.value = _getProjectName();
    }
    return _mapName.value;
  }

  static Future<bool> addDependencies(String package,
      {String version, bool isDev = false, bool runPubGet = true}) async {
    var lines = _pubspec.readAsLinesSync();
    if (containsPackage(package)) {
      // ignore: avoid_print
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

  static void removeDependencies(String package, {bool logger = true}) {
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

    var i = lines.indexWhere((element) => element.startsWith('  $package:'));
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
    var index =
        lines.indexWhere((element) => element.startsWith('  $package:'));
    if (index != -1) {
      try {
        var version =
            Version.parse(lines[index].split(':').last.trim().removeAll('^'));
        return version;
      } on FormatException catch (_) {
        return null;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      throw CliException(
          LocaleKeys.info_package_not_installed.trArgs([package]));
    }
  }

  static String get separatorFileType {
    if (!_mapSep.isChecked) {
      _mapSep.value = _separatorFileType;
    }
    return _mapSep.value;
  }

  static String get _separatorFileType {
    _mapSep.isChecked = true;
    var yaml = loadYaml(_pubspec.readAsStringSync()) as YamlMap;
    if (yaml.containsKey('get_cli')) {
      if ((yaml['get_cli'] as Map).containsKey('separator')) {
        return (yaml['get_cli']['separator'] as String) ?? '';
      }
    }

    return '';
  }

  static bool get extraFolder {
    if (!_extraFolder.isChecked) {
      _extraFolder.value = _getExtraFolder;
    }
    return _extraFolder.value;
  }

  static bool get _getExtraFolder {
    _extraFolder.isChecked = true;
    try {
      var yaml = loadYaml(_pubspec.readAsStringSync()) as YamlMap;
      if (yaml.containsKey('get_cli')) {
        if ((yaml['get_cli'] as Map).containsKey('sub_folder')) {
          return (yaml['get_cli']['sub_folder'] as bool);
        }
      }
    } on Exception catch (_) {}
    // ignore: avoid_returning_null
    //esse retorno vai ser tratado;
    return null;
  }
}

class _PubValue<T> {
  bool isChecked;
  T value;
  _PubValue([this.value, this.isChecked = false]);
}
