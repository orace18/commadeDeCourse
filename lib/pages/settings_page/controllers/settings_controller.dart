import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/providers/theme/theme.dart';

class SettingsController extends GetxController {

  final box = GetStorage('Otrip');
  var isLightMode = true;
  late var language ;

  @override
  void onInit() {
    isLightMode = box.read("darkTheme") ?? false;
    super.onInit();
  }

  void changeThemeMode() {
    var theme = AppTheme.lightTheme;
    if(Get.isDarkMode){
      theme = AppTheme.lightTheme;
      box.write("darkTheme", false);
    } else {
      theme = AppTheme.darkTheme;
      box.write("darkTheme", true);
    }
    Get.changeTheme(
      theme
    );
  }

  void changeAppLanguage() {
    Get.updateLocale(
        Get.locale == const Locale("fr","FR") ? const Locale("en","US") : const Locale("fr","FR")
    );
  }

  void navigateBack() => Get.back();
}
