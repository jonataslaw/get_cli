import 'dart:io';

import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:recase/recase.dart';

void addDependencieToBinding(String path, String controllerName, import) {
  import = '''import 'package:${PubspecUtils.getProjectName()}/$import';''';
  File file = File(path);
  if (file.existsSync()) {
    List<String> lines = file.readAsLinesSync();
    lines.insert(2, import);
    int index = lines.indexWhere((element) {
      element = element.trim();
      return element.startsWith('void dependencies() {');
    });
    index++;
    lines.insert(
        index, '''\t\tGet.lazyPut<${controllerName.pascalCase}Controller>(
\t\t\t() => ${controllerName.pascalCase}Controller(),
\t\t);''');
    file.writeAsStringSync(lines.join('\n'));
  }
}
