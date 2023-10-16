import 'package:get/get.dart';
import 'profile_edit_info_controller.dart';

class ProfileEditInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileEditInfoController>(() => ProfileEditInfoController());
  }
}
