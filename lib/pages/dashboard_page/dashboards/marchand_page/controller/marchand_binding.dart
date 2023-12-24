import 'package:get/get.dart';
import 'marchand_controller.dart';

class MarchandBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarchandController>(() => MarchandController());
  }
}
