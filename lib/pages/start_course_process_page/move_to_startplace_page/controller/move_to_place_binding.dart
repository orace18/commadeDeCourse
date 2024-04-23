import 'package:get/get.dart';
import 'package:otrip/pages/start_course_process_page/move_to_startplace_page/controller/move_to_place_controller.dart';

class MoveToStartPlaceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MoveToStartPlaceController>(() => MoveToStartPlaceController());
  }

}