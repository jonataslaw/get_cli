import 'package:get_cli/samples/interface/sample_interface.dart';

class AppPagesSample extends Sample {
  @override
  String file(String fileName) {
    return '''
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
  ];
}
''';
  }
}
