import 'package:get_cli/samples/interface/sample_interface.dart';
import 'package:recase/recase.dart';

//Usei arc pra fazer reencia a clean do katekko
class ArcSceeenSample extends Sample {
  @override
  String file(String fileName) {
    return '''
import 'controllers/${fileName.snakeCase}.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ${fileName.pascalCase}Screen extends GetView<${fileName.pascalCase}Controller> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('${fileName.pascalCase}Screen '),
      centerTitle: true,),
      body: Center(
        child: Text('${fileName.pascalCase}Screen  is working', style: TextStyle(fontSize:20),),
      ),
    );
  }
}
''';
  }
}
