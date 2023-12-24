import 'package:get/get.dart';

import 'profile_edit_marchand_controller.dart';


class ProfileEditMarchandBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileEditMarchandController>(() => ProfileEditMarchandController());
  }
}
