import 'package:get_cli/samples/interface/sample_interface.dart';

class RouteSample extends Sample {
  @override
  String file(String fileName, {bool isArc = false, String initial = 'HOME'}) {
    return !isArc
        ? '''part of 'app_pages.dart';

abstract class Routes{

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
