import 'package:recase/recase.dart';
import '../interface/sample_interface.dart';

/// [Sample] file from Provider file creation.
class ProviderSample extends Sample {
  final String _fileName;
  final bool _isServer;
  ProviderSample(String path, this._fileName, this._isServer,
      {bool overwrite = false})
      : super(path, overwrite: overwrite);

  String get _import => _isServer
      ? "import 'package:get_server/get_server.dart';"
      : "import 'package:get/get.dart';";

  @override
  Future<String> get content async => '''$_import

class ${_fileName.pascalCase}Provider extends GetConnect {
\t@override
\tvoid onInit() {
\t\thttpClient.baseUrl = 'YOUR-API-URL';
\t}

}
''';
}
