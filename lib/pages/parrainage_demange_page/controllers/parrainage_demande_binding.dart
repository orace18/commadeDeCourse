import 'package:get/get.dart';
import 'package:otrip/pages/parrainage_demange_page/controllers/parrainage_demande_controller.dart';

class DemandeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DemandeController>(() => DemandeController());
  }
}
