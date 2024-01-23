import 'package:get/get.dart';
import 'package:otrip/pages/courses_page/controllers/do_course_controller.dart';

class DoCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoCourseController>(() => DoCourseController());
  }
}