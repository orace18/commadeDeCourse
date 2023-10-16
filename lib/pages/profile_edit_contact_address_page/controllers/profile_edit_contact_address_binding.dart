import 'package:get/get.dart';
import 'profile_edit_contact_address_controller.dart';

class ProfileEditContactAddressBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileEditContactAddressController>(() => ProfileEditContactAddressController());
  }
}
