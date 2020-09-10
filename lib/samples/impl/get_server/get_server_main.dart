import 'package:get_cli/samples/interface/sample_interface.dart';

class GetServerMainSample extends Sample {
  GetServerMainSample() : super('lib/main.dart', overwrite: true);

  @override
  Future<String> get content async =>
      '''import 'package:get_server/get_server.dart';
import 'routes/app_pages.dart';

void main() {
  runApp(GetServer(
    getPages: AppPages.routes,
  ));
}
  ''';
}
