import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'teste_controller.dart';

class TesteView extends  GetView<TesteController>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste')
      ), 
      body: Container(),
    );
  }
}
  