import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/samples/interface/sample_interface.dart';

class GetViewSample extends Sample {
  String controllerDir;
  String viewName;
  String controller;
  bool isServer;

  GetViewSample(String path, this.viewName, this.controller, this.controllerDir,
      this.isServer,
      {bool overwrite = false})
      : super(path, overwrite: overwrite);

  Future<String> get import async => controllerDir != null
      ? '''\nimport 'package:${await PubspecUtils.getProjectName()}/$controllerDir';'''
      : '';

  String get _controller =>
      controller != null ? 'GetView<$controller>' : 'GetView';

  Future<String> get _flutterView async =>
      '''import 'package:flutter/material.dart';
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

  Future<String> get _serverView async =>
      '''import 'package:get_server/get_server.dart'; ${await import}

class $viewName extends GetView<$controller> {
  @override
  Widget build(BuildContext context) {
    return Text('GetX to Server is working!');
  }
}
  ''';

  @override
  Future<String> get content async => isServer ? _serverView : _flutterView;
}
