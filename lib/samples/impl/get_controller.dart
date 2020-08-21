import 'package:recase/recase.dart';

import '../interface/sample_interface.dart';

class ControllerSample extends Sample {
  @override
  String file(String fileName, {bool isArc = false}) {
    return !isArc
        ? '''import 'package:get/get.dart';

class ${fileName}Controller extends GetxController {

  @override
  void onInit() => null;
  
  final count = 0.obs;
}
'''
        : ''' 
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ${fileName.pascalCase}Controller extends GetxController{

  ${fileName.pascalCase}Controller({@required Map screenArgs});

  //TODO: ${fileName.pascalCase}Controller
}
''';
  }
}
