import 'package:get/get.dart';
import 'profile_edit_company_controller.dart';

class ProfileEditCompanyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileEditCompanyController>(() => ProfileEditCompanyController());
  }
}
