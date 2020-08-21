import 'package:get_cli/samples/interface/sample_interface.dart';

class RouteSample extends Sample {
  @override
  String file(String fileName, {bool isArc = false, String initial = 'HOME'}) {
    return !isArc
        ? '''import 'package:get/get.dart';
import '../pages/home/home_view.dart';
class Routes {

  static final String initial = '/home';

  static final paths = [
    GetPage(name: '/home', page: () => HomeView()),
  ];
}

'''
        : ''' 
class Routes {
  static Future<String> get initialRoute async {
    // TODO: implement method
    return $initial;
  }
}
''';
  }
}
