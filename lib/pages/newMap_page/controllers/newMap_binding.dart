import 'package:get/get.dart';
import 'newMap_controller.dart';

class NewMapBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewMapController>(() => NewMapController());
  }
}
