import 'package:get_cli/samples/interface/sample_interface.dart';
import 'package:recase/recase.dart';

class BindingSample extends Sample {
  @override
  String file(String fileName, {isArc = false}) {
    return !isArc
        ? '''import 'package:get/get.dart';

import '${fileName.snakeCase}_controller.dart';

class ${fileName.pascalCase}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${fileName.pascalCase}Controller>(() => ${fileName.pascalCase}Controller());
  }
}
'''
        : '''import 'package:get/get.dart';

import '../../../../presentation/${fileName.snakeCase}/controllers/${fileName.snakeCase}.controller.dart';

class ${fileName.pascalCase}ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${fileName.pascalCase}Controller>(
      () => ${fileName.pascalCase}Controller(),
    );
  }
}
''';
  }
}
