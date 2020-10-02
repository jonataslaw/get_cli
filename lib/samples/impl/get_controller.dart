import 'package:recase/recase.dart';

import '../interface/sample_interface.dart';

class ControllerSample extends Sample {
  String fileName;
  bool isServer;
  ControllerSample(String path, this.fileName, this.isServer,
      {bool overwrite = false})
      : super(path, overwrite: overwrite);

  String get import => isServer
      ? "import 'package:get_server/get_server.dart';"
      : "import 'package:get/get.dart';";

  @override
  Future<String> get content async => '''$import

class ${fileName.pascalCase}Controller extends GetxController {
  //TODO: Implement ${fileName.pascalCase}Controller
  
  final count = 0.obs;

  @override
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  void increment() => count.value++;
}
''';
}
