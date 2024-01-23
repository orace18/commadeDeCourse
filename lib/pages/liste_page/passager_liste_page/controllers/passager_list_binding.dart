import 'package:get/get.dart';
import 'package:otrip/pages/liste_page/passager_liste_page/controllers/passager_list_controller.dart';


class PassagerListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PassagerListController>(() => PassagerListController());
  }
}
