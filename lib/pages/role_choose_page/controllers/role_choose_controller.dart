import 'package:get/get.dart';

class RoleChooseController extends GetxController {
  void navigateBack() => Get.back();

  RxInt selectedRoleId = RxInt(0);

  void setSelectedRole(int roleId) {
    selectedRoleId.value = roleId;
  }
}
