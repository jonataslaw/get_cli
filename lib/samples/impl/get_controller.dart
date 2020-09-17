import 'package:recase/recase.dart';

import '../interface/sample_interface.dart';

class ControllerSample extends Sample {
  String fileName;
  ControllerSample(String path, this.fileName, {bool overwrite = false})
      : super(path, overwrite: overwrite);

  @override
  Future<String> get content async => '''import 'package:get/get.dart';

class ${fileName.pascalCase}Controller extends GetxController {
  //TODO: Implement ${fileName.pascalCase}Controller
  
  final count = 0.obs;

  @override
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  increment() => count.value++;
}
''';
}
