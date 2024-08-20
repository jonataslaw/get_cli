import 'dart:io';

import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:yaml/yaml.dart';

import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../../../extensions.dart';
import '../../menu/menu.dart';
import '../logger/log_utils.dart';
import '../shell/shel.utils.dart';

// ignore: avoid_classes_with_only_static_members
class PubspecUtils {
  static final _pubspecFile = File('pubspec.yaml');

  static Pubspec get pubSpec => Pubspec.parse(pubspecString);

  static String get pubspecString => _pubspecFile.readAsStringSync();

  static get pubspecJson => loadYaml(pubspecString);

  /// separtor
  static final _mapSep = _PubValue<String>(() {
    var yaml = pubspecJson;

    if (yaml.containsKey('get_cli')) {
      if ((yaml['get_cli'] as Map).containsKey('separator')) {
        return (yaml['get_cli']['separator'] as String?) ?? '';
      }
    }

    return '';
  });

  static String? get separatorFileType => _mapSep.value;

  static final _mapName = _PubValue<String>(() => pubSpec.name.trim());

  static String? get projectName => _mapName.value;

  static final _extraFolder = _PubValue<bool?>(
    () {
      try {
        var yaml = pubspecJson;
        if (yaml.containsKey('get_cli')) {
          if ((yaml['get_cli'] as Map).containsKey('sub_folder')) {
            return (yaml['get_cli']['sub_folder'] as bool?);
          }
        }
      } on Exception catch (_) {}
      // retorno nulo está sendo tratado
      // ignore: avoid_returning_null
      return null;
    },
  );

  static bool? get extraFolder => _extraFolder.value;

  static Future<bool> addDependencies(String package,
      {String? version, bool isDev = false, bool runPubGet = true}) async {
    if (containsPackage(package)) {
      LogService.info(
          LocaleKeys.ask_package_already_installed.trArgs([package]),
          false,
          false);
      final menu = Menu(
        [
          LocaleKeys.options_yes.tr,
          LocaleKeys.options_no.tr,
        ],
      );
      final result = menu.choose();
      if (result.index != 0) {
        return false;
      }
    }

    String packageName = package;

    if (version != null && version.isNotEmpty) {
      packageName = '$package:$version';
    }

    if (isDev) {
      packageName = 'dev:$packageName';
    }

    await ShellUtils.addPackage(packageName);

    // version = version == null || version.isEmpty
    //     ? await PubDevApi.getLatestVersionFromPackage(package)
    //     : '^$version';
    // if (version == null) return false;
    // final dependency = HostedDependency(
    //   version: VersionConstraint.parse(version),
    // );

    // if (isDev) {
    //   pubSpec.devDependencies[package] = dependency;
    // } else {
    //   pubSpec.dependencies[package] = dependency;
    // }

    // _savePub(pubSpec);
    if (runPubGet) await ShellUtils.pubGet();
    LogService.success(LocaleKeys.sucess_package_installed.trArgs([package]));
    return true;
  }

  static Future<void> removeDependencies(String package,
      {bool logger = true}) async {
    if (logger) LogService.info('Removing package: "$package"');

    await ShellUtils.removePackage(package);
    if (!containsPackage(package)) {
      // var dependencies = pubSpec.dependencies;
      // var devDependencies = pubSpec.devDependencies;

      // dependencies.removeWhere((key, value) => key == package);
      // devDependencies.removeWhere((key, value) => key == package);
      // pubSpec.dependencies.clear();
      // pubSpec.devDependencies.clear();
      // pubSpec.dependencies.addAll(dependencies);
      // pubSpec.devDependencies.addAll(devDependencies);
      // var newPub = pubSpec.copy(
      //   devDependencies: devDependencies,
      //   dependencies: dependencies,
      // );

      // _savePub(pubSpec);
      if (logger) {
        LogService.success(LocaleKeys.sucess_package_removed.trArgs([package]));
      }
    } else if (logger) {
      LogService.info(LocaleKeys.info_package_not_installed.trArgs([package]));
    }
  }

  static bool containsPackage(String package, [bool isDev = false]) {
    var dependencies = isDev ? pubSpec.devDependencies : pubSpec.dependencies;
    return dependencies.containsKey(package.trim());
  }

  static bool get nullSafeSupport => !pubSpec.environment!['sdkConstraint']!
      .allowsAny(VersionConstraint.parse('<2.12.0'));

  /// make sure it is a get_server project
  static bool get isServerProject {
    return containsPackage('get_server');
  }

  static String get getPackageImport => !isServerProject
      ? "import 'package:get/get.dart';"
      : "import 'package:get_server/get_server.dart';";

  // static v.Version? getPackageVersion(String package) {
  //   if (containsPackage(package)) {
  //     pubSpec.dependencies.containsKey(pa)
  //     var version = pubSpec.allDependencies[package]!;
  //     try {
  //       final json = version.toJson();
  //       if (json is String) {
  //         return v.Version.parse(json);
  //       }
  //       return null;
  //     } on FormatException catch (_) {
  //       return null;
  //     } on Exception catch (_) {
  //       rethrow;
  //     }
  //   } else {
  //     throw CliException(
  //         LocaleKeys.info_package_not_installed.trArgs([package]));
  //   }
  // }

  // static void _savePub(Pubspec pub) {
  //   var value = CliYamlToString().toYamlString(pub.toJson());
  //   _pubspecFile.writeAsStringSync(value);
  // }
}

/// avoids multiple reads in one file
class _PubValue<T> {
  final T Function() _setValue;
  bool _isChecked = false;
  T? _value;

  /// takes the value of the file,
  /// if not already called it will call the first time
  T? get value {
    if (!_isChecked) {
      _isChecked = true;
      _value = _setValue.call();
    }
    return _value;
  }

  _PubValue(this._setValue);
}
