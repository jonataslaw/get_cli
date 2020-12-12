import 'package:recase/recase.dart';
import '../interface/sample_interface.dart';

/// [Sample] file from Module_Controller file creation.
class ControllerSample extends Sample {
  final String _fileName;
  final bool _isServer;
  ControllerSample(String path, this._fileName, this._isServer,
      {bool overwrite = false})
      : super(path, overwrite: overwrite);

  String get _import => _isServer
      ? "import 'package:get_server/get_server.dart';"
      : "import 'package:get/get.dart';";

  @override
  String get content => '''$_import

class ${_fileName.pascalCase}Controller extends GetxController {
  //TODO: Implement ${_fileName.pascalCase}Controller
  
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
