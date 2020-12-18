import 'dart:io';

import 'package:recase/recase.dart';

import '../../common/utils/logger/LogUtils.dart';
import '../../common/utils/pubspec/pubspec_utils.dart';
import '../../core/internationalization.dart';
import '../../core/locales.g.dart';
import '../create/create_single_file.dart';

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
    LogService.success(LocaleKeys.sucess_add_controller_in_bindings
        .trArgs([controllerName.pascalCase, path]));
  }
}
