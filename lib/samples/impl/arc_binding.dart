import 'package:get_cli/samples/interface/sample_interface.dart';
import 'package:recase/recase.dart';

//Usei arc pra fazer reencia a clean do katekko
class ArcBindingsSample extends Sample {
  @override
  String file(String fileName) {
    return '''
import '../../../../presentation/${fileName.snakeCase}/controllers/${fileName.snakeCase}.controller.dart';
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
