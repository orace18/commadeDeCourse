import 'package:get/get.dart';
import 'package:otrip/pages/profile_page/controllers/profile_marchand_controller.dart';

class MerchantProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MerchantController>(() => MerchantController());
  }
}
