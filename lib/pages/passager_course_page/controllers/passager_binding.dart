
import 'package:get/get.dart';
import 'package:otrip/pages/passager_course_page/controllers/passager_controller.dart';

class MyCourseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyCourseController>(() => MyCourseController());
  }
}
