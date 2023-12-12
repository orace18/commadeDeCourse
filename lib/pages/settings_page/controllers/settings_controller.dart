import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/providers/theme/theme.dart';

class SettingsController extends GetxController {

  final box = GetStorage('Otrip');
  late var isLightMode ;

  @override
  void onInit() {
    isLightMode = box.read("lightTheme");
    super.onInit();
  }
  void changeThemeMode() {
    Get.changeTheme(
      Get.isDarkMode ? AppTheme.lightTheme : AppTheme.darkTheme
    );
  }

  void changeAppLanguage() {
    Get.updateLocale(
        Get.locale == const Locale("fr","FR") ? const Locale("en","US") : const Locale("fr","FR")
    );
  }

  void navigateBack() => Get.back();
}
