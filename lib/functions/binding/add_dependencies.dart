import 'dart:io';

import 'package:get_cli/common/utils/logger/LogUtils.dart';
import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/functions/create/create_single_file.dart';
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
    lines.insert(index, '''Get.lazyPut<${controllerName.pascalCase}Controller>(
          () => ${controllerName.pascalCase}Controller(),
);''');
    writeFile(file.path, lines.join('\n'), overwrite: true, logger: false);
    LogService.success('The ${controllerName.pascalCase} has been added '
        'to binging at path: ${file.path}');
  }
}
