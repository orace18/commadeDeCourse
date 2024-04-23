import 'package:get/get.dart';
import 'package:otrip/pages/send_message_page/controller/send_message_controller.dart';

class SendMessageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SendMessageController>(() => SendMessageController());
  }

}