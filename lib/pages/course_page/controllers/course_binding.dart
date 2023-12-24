import 'package:get/get.dart';
import 'package:otrip/pages/course_page/controllers/course_controller.dart';

class CourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseController>(() => CourseController());
  }
}
