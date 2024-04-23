import 'package:get/get.dart';
import 'package:otrip/pages/realtime_map_page/find_driver_map/controllers/find_driver_controller.dart';

class FindDriverOnMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindDriverOnMapController>(() => FindDriverOnMapController());
  }
}
