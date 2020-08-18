import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'message_controller.dart';

class MessageView extends  GetView<MessageController>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message')
      ), 
      body: Container(),
    );
  }
}
  