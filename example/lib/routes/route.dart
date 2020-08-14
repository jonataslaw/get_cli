
import 'package:get/get.dart';
import '../pages/home/home_view.dart';
class Routes {

  static final String initial = '/home';

  static final paths = [
    GetPage(name: '/home', page: () => HomeView()),
  ];
}

