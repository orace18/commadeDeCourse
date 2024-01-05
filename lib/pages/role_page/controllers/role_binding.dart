import 'package:get/get.dart';
import 'role_controller.dart';

class RoleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleController>(() => RoleController());
  }
}
