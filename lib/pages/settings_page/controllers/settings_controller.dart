import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/providers/theme/theme.dart';

class SettingsController extends GetxController {

  final box = GetStorage('Otrip');
  final isLightMode = true.obs;
  final language = Get.locale.obs;
  final languageKey = GlobalKey<FormFieldState>();

  void changeThemeMode() {
    var theme = AppTheme.lightTheme;
    if(Get.isDarkMode){
      theme = AppTheme.lightTheme;
    } else {
      theme = AppTheme.darkTheme;
    }
    Get.changeTheme(
      theme
    );
    isLightMode.value = !isLightMode.value;
  }

  void changeAppLanguage( Locale locale) {
    Get.updateLocale(
        language.value = locale
    );
  }

  void navigateBack() => Get.back();
}
