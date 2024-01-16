import 'package:get/get.dart';
import 'package:otrip/pages/liste_page/passager_liste_page/controllers/specific_drivers_controller.dart';


class SpecificDriverBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecificDriverController>(() => SpecificDriverController());
  }
}
