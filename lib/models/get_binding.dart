import 'package:get_cli/sample_interface.dart';

class BindingSample extends Sample {
  @override
  String file(String fileName) {
    return '''
import 'package:get/get.dart';
import '${fileName.toLowerCase()}_controller.dart';

class ${fileName}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${fileName}Controller>(() => ${fileName}Controller());
  }
}
''';
  }
}
