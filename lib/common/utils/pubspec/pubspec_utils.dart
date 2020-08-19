import 'dart:io';
import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pub_dev/pub_dev_api.dart';
import 'package:get_cli/common/utils/shell/shel.utils.dart';

class PubspecUtils {
  static var _pubspec = File('pubspec.yaml');

  static void addDependencies(String package,
      {String version, bool isDev = false}) async {
    try {
      var lines = _pubspec.readAsLinesSync();
      // Adicione aqui tambem para não instalar uma dependência 2 vezes.
      lines
          .removeWhere((element) => element.split(':').first.trim() == package);
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
      await ShellUtils.pubGet();
      LogService.success('Package: $package installed!');
    } on FileSystemException catch (e) {
      _onFileSystemError(e);
    } catch (e) {
      LogService.error('an unexpected error occurred : ${e.runtimeType}');
    }
  }

  static void removeDependencies(String package) async {
    try {
      LogService.info('Removing package: $package');

      var lines = _pubspec.readAsLinesSync();
      /* I changed the method so that it would not give an error 
      if the dependency was not found
    */
      lines
          .removeWhere((element) => element.split(':').first.trim() == package);
      await _pubspec.writeAsStringSync(lines.join('\n'));
      LogService.success('Package: $package removed!');
    } on FileSystemException catch (e) {
      _onFileSystemError(e);
    } catch (e) {
      LogService.error('an unexpected error occurred : ${e.runtimeType}');
    }
  }

  static void _onFileSystemError(FileSystemException e) {
    if (e.osError.errorCode == 2) {
      LogService.error('pubspec.yaml in not found in the current directory, ' +
          'are you in the root folder?');
      return;
    } else if (e.osError.errorCode == 13) {
      LogService.error('you are not allowed to access pubspec.yaml');
      return;
    }
    LogService.error('an unexpected error occurred : ${e.message}');
  }
}
