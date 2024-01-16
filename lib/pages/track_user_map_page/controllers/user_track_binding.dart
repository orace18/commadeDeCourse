import 'package:get/get.dart';
import 'package:otrip/pages/track_user_map_page/controllers/user_track_controller.dart';


class TrackMapBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackMapController>(() => TrackMapController());
  }
}
