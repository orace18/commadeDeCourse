import 'package:get/get.dart';
import 'package:otrip/pages/selecte_place_page/controllers/search_place_controller.dart';


class NeighborhoodsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NeighborhoodsController>(() => NeighborhoodsController());
  }
}
