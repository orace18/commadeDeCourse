import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {

  final box = GetStorage('Otrip');
  late var isLightMode ;

  @override
  void onInit() {
    isLightMode = box.read("lightTheme");
    super.onInit();
  }
  void themeModeChanged() {

  }
  void navigateBack() => Get.back();
}
