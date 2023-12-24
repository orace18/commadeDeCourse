import 'package:get/get.dart';

import 'profile_edit_conducteur_controller.dart';

class ProfileEditDriverBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileEditDriverController>(
        () => ProfileEditDriverController());
  }
}
