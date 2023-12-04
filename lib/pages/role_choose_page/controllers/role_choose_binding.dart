import 'package:get/get.dart';
import 'role_choose_controller.dart';

class TestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleChooseController>(() => RoleChooseController());
  }
}
