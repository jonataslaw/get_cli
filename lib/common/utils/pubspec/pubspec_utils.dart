import 'dart:io';

import 'package:html/parser.dart';
import 'package:http/http.dart';

class PubspecUtils {
  Future<String> _getPubspecDir() async {
    var presentationDir = Directory.current;
    List allContents = await presentationDir.listSync();
    for (var dir in allContents) {
      if (dir is File) {
        if (extractFileName(dir.path) == 'pubspec.yaml') return dir.path;
      }
    }
    return null;
  }

  String extractFileName(String path) {
    return Platform.isWindows ? path.split('\\').last : path.split('/').last;
  }

  Future<String> getProjectName() async {
    var dir = await _getPubspecDir();
    if (dir != null) {
      var f = File(dir);
      f.readAsLinesSync().forEach((line) {
        if (line.startsWith('name:')) {
          return line.split(':').last;
        }
      });
    }
    return null;
  }

  void addDependencies(String package, {String version}) async {
    var pubspec = File('pubspec.yaml');
    var lines = pubspec.readAsLinesSync();
    var index =
        lines.indexWhere((element) => element.trim() == 'dev_dependencies:');
    while (lines[index - 1].isEmpty) {
      index--;
    }
    version = version == null || version.isEmpty
        ? await PubDev.getLasteVersion(package)
        : ' ^$version';
    lines.insert(index, '  $package: $version');
    await pubspec.writeAsStringSync(lines.join('\n'));
  }
}

class PubDev {
  static Future<String> getLasteVersion(String package) async {
    var res = await get('https://pub.dev/packages/$package/install');
    var document = parse(res.body);
    var inputElement =
        document.getElementsByClassName('language-yaml').first.text;
    var hh = inputElement.split(':');

    return hh.last.trim();
  }
}
