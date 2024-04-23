import 'package:get/get.dart';
import 'package:otrip/pages/start_course_process_page/start_course_page/controller/start_course_controller.dart';

class StartCourseBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<StartCourseController>(() => StartCourseController());
  }

}