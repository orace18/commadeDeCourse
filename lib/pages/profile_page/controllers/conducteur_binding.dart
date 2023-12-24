import 'package:get/get.dart';
import 'profile_controller.dart';

class DriverProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
