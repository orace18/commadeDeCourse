import 'package:get/get.dart';
import 'activities_controller.dart';

class ActivitiesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivitiesController>(() => ActivitiesController());
  }
}
