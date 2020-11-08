import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:get_cli/samples/interface/sample_interface.dart';

/// [Sample] file from Module_View file creation.
class GetViewSample extends Sample {
  final String _controllerDir;
  final String _viewName;
  final String _controller;
  final bool _isServer;

  GetViewSample(String path, this._viewName, this._controller,
      this._controllerDir, this._isServer,
      {bool overwrite = false})
      : super(path, overwrite: overwrite);

  Future<String> get import async => _controllerDir != null
      ? '''\nimport 'package:${await PubspecUtils.getProjectName()}/$_controllerDir';'''
      : '';

  String get _controllerName =>
      _controller != null ? 'GetView<$_controller>' : 'GetView';

  Future<String> get _flutterView async =>
      '''import 'package:flutter/material.dart';
import 'package:get/get.dart'; ${await import}

class $_viewName extends $_controllerName {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_viewName'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          '$_viewName is working', 
          style: TextStyle(fontSize:20),
        ),
      ),
    );
  }
}
  ''';

  Future<String> get _serverView async =>
      '''import 'package:get_server/get_server.dart'; ${await import}

class $_viewName extends GetView<$_controller> {
  @override
  Widget build(BuildContext context) {
    return Text('GetX to Server is working!');
  }
}
  ''';

  @override
  Future<String> get content async => _isServer ? _serverView : _flutterView;
}
