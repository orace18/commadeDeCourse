import 'package:get/get.dart';
import 'profile_edit_seats_controller.dart';

class ProfileEditSeatsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileEditSeatsController>(() => ProfileEditSeatsController());
  }
}
