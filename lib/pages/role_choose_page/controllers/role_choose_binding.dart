import 'package:get/get.dart';
import 'role_choose_controller.dart';

class RoleChooseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleChooseController>(() => RoleChooseController());
  }
}
