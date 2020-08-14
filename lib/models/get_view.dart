import 'package:get_cli/sample_interface.dart';

class GetViewSample extends Sample {
  @override
  String file(String fileName) {
    return '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '${fileName.toLowerCase()}_controller.dart';

class ${fileName}View extends  GetView<${fileName}Controller>  {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${fileName}')
      ), 
      body: Container(),
    );
  }
}
  ''';
  }
}
