import 'package:get/get.dart';
import 'package:location/location.dart';

class NewMapController extends GetxController {
  void navigateBack() => Get.back();

  late LocationData initialPosition;

  RxBool isLoadingPosition = true.obs;

  @override
  void onInit() {
    getLocation();
    super.onInit();
  }

  void getLocation(){
    Location location = Location();
    location.getLocation().then((location) {
      initialPosition = location;
      isLoadingPosition = false.obs;
    });
  }
}
