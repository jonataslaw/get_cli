import 'package:get_cli/samples/interface/sample_interface.dart';

class AppPagesSample extends Sample {
  AppPagesSample({String path = 'lib/routes/app_pages.dart'}) : super(path);

  @override
  Future<String> get content async => '''
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
  ];
}
''';
}
