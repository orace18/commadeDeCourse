import 'package:get/get.dart';
import 'course_controller.dart';

class LegalmentionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationPickerController>(() => LocationPickerController());
  }
}
