import 'package:get/get.dart';
import 'add_user_controller.dart';

class AddUserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddUserController>(() => AddUserController());
  }
}
