import 'package:get/get.dart';
import 'message_controller.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(() => MessageController());
  }
}
