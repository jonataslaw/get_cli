import 'package:get_cli/samples/interface/sample_interface.dart';
import 'package:recase/recase.dart';

class BindingSample extends Sample {
  @override
  String file(String fileName, {isArc = false}) {
    return !isArc
        ? '''import 'package:get/get.dart';
import '${fileName.toLowerCase()}_controller.dart';

class ${fileName}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${fileName}Controller>(() => ${fileName}Controller());
  }
}
'''
        : '''import '../../../../presentation/${fileName.snakeCase}/controllers/${fileName.snakeCase}.controller.dart';
import 'package:get/get.dart';

class ${fileName.pascalCase}ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${fileName.pascalCase}Controller>(
          () => ${fileName.pascalCase}Controller(screenArgs: Get.arguments),
    );
  }
}
''';
  }
}
