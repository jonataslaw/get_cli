import 'package:get_cli/samples/interface/sample_interface.dart';
import 'package:recase/recase.dart';

//Usei arc pra fazer reencia a clean do katekko
class ArcControllerSample extends Sample {
  @override
  String file(String fileName) {
    return '''
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ${fileName.pascalCase}Controller extends GetxController{

  ${fileName.pascalCase}Controller({@required Map screenArgs});

  //TODO: ${fileName.pascalCase}Controller
}



''';
  }
}
