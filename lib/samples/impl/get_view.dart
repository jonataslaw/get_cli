import 'package:get_cli/samples/interface/sample_interface.dart';
import 'package:recase/recase.dart';

class GetViewSample extends Sample {
  @override
  String file(String fileName) {
    return '''import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '${fileName.toLowerCase().snakeCase}_controller.dart';

class ${fileName.pascalCase}View extends  GetView<${fileName.pascalCase}Controller>  {
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
