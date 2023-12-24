import 'package:get/get.dart';
import 'package:otrip/pages/passager_demande_page/controllers/passager_demande_controller.dart';



class PassagerDemandeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PassagerDemandeController>(() => PassagerDemandeController());
  }
}
