import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/samples/interface/sample_interface.dart';
import 'package:recase/recase.dart';

/// [Sample] file from Module_Binding file creation.
class BindingSample extends Sample {
  final String _fileName;
  final String _controllerDir;
  final String _bindingName;
  final bool _isServer;

  BindingSample(String path, this._fileName, this._bindingName,
      this._controllerDir, this._isServer,
      {bool overwrite = false})
      : super(path, overwrite: overwrite);

  String get _import => _isServer
      ? "import 'package:get_server/get_server.dart';"
      : "import 'package:get/get.dart';";

  @override
  Future<String> get content async => '''$_import
import 'package:${PubspecUtils.getProjectName()}/$_controllerDir';

class $_bindingName extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${_fileName.pascalCase}Controller>(
      () => ${_fileName.pascalCase}Controller(),
    );
  }
}
''';
}
