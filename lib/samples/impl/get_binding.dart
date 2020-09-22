import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/samples/interface/sample_interface.dart';
import 'package:recase/recase.dart';

class BindingSample extends Sample {
  String fileName;
  String controllerDir;
  String bindingName;
  bool isServer;

  BindingSample(String path, this.fileName, this.bindingName,
      this.controllerDir, this.isServer,
      {bool overwrite = false})
      : super(path, overwrite: overwrite);

  String get import => isServer
      ? "import 'package:get_server/get_server.dart';"
      : "import 'package:get/get.dart';";

  @override
  Future<String> get content async => '''$import

import 'package:${await PubspecUtils.getProjectName()}/$controllerDir';

class $bindingName extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${fileName.pascalCase}Controller>(
      () => ${fileName.pascalCase}Controller(),
    );
  }
}
''';
}
