import 'package:get/get.dart';
import 'assistance_controller.dart';

class AssistanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssistanceController>(() => AssistanceController());
  }
}
