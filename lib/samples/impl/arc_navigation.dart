import 'package:get_cli/samples/interface/sample_interface.dart';

class ArcNavigationSample extends Sample {
  @override
  String file(String filename) {
    return '''import 'package:get/get.dart';

import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class Nav {
  static List<GetPage> routes = [
  ];
}''';
  }
}
