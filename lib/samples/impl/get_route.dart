import 'package:get_cli/samples/interface/sample_interface.dart';

class RouteSample extends Sample {
  @override
  String file(String fileName, {bool isArc = false, String initial = 'HOME'}) {
    return !isArc
        ? '''part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes{

}

'''
        : '''// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

class Routes {
  static Future<String> get initialRoute async {
    // TODO: implement method
    return $initial;
  }
}
''';
  }
}
