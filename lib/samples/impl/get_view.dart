import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/samples/interface/sample_interface.dart';

class GetViewSample extends Sample {
  String controllerDir;
  String viewName;
  String controller;

  GetViewSample(String path, this.viewName, this.controller, this.controllerDir,
      {bool overwrite = false})
      : super(path, overwrite: overwrite);
  String get _controller =>
      controller != null ? 'GetView<$controller>' : 'GetView';

  Future<String> get import async => controllerDir != null
      ? '''\nimport  'package:${await PubspecUtils.getProjectName()}/$controllerDir';'''
      : '';
  @override
  Future<String> get content async => '''import 'package:flutter/material.dart';
import 'package:get/get.dart'; ${await import}

class $viewName extends $_controller {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('$viewName'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          '$viewName is working', 
          style: TextStyle(fontSize:20),
        ),
      ),
    );
  }
}
  ''';
}
