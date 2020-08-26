import 'package:get_cli/samples/interface/sample_interface.dart';

class AppPagesSample extends Sample {
  @override
  String file(String fileName) {
    return '''import '../pages/home/home_binding.dart';
import '../pages/home/home_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {

  static final routes = [
    GetPage(name: Routes.INITIAL, page:()=> HomeView(), binding: HomeBinding()),
  ];
}
''';
  }
}
