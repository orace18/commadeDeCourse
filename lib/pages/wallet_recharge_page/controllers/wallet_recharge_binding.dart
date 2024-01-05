import 'package:get/get.dart';
import 'wallet_recharge_controller.dart';

class WalletRechargeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletRechargeController>(() => WalletRechargeController());
  }
}
