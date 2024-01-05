import 'package:get/get.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/controllers/passager_controller.dart';


class PassagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PassagerController>(() => PassagerController());
  }
}
