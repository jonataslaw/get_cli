import '../interface/sample_interface.dart';

class ControllerSample extends Sample {
  @override
  String file(String fileName) {
    return '''
import 'package:get/get.dart';

class ${fileName}Controller extends GetxController {

  @override
  void onInit() => null;
  
  final count = 0.obs;
}
''';
  }
}
