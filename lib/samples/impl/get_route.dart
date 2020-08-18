import 'package:get_cli/samples/interface/sample_interface.dart';

class RouteSample extends Sample {
  @override
  String file(String fileName) {
    return '''

import 'package:get/get.dart';
import '../pages/home/home_view.dart';
class Routes {

  static final String initial = '/home';

  static final paths = [
    GetPage(name: '/home', page: () => HomeView()),
  ];
}

''';
  }
}

// class RouteSample extends Sample {
//   @override
//   String file(String fileName) {
//     return '''

// import 'package:get/get.dart';
// import '../pages/home/${fileName.toLowerCase()}_view.dart';
// class Routes {

//   static final String initial = '/home';

//   static final paths = [
//     GetPage(name: '/${fileName.toLowerCase()}', page: () => ${fileName}View()),
//   ];
// }

// ''';
//   }
// }
