import 'package:get/get.dart';

import 'demande_controller.dart';

class DemandeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DemandeController>(() => DemandeController());
  }
}
