import 'package:get_cli/samples/interface/sample_interface.dart';

class ArcNavigationSample extends Sample {
  @override
  String file(String filename) {
    return '''import '../../infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

class Nav {
  static List<GetPage> routes = [
  ];
}''';
  }
}
