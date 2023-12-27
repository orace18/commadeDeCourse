import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController{
  final isInSplashScreen = false.obs;
  final box = GetStorage();

  setIsInSplashScreen(bool value) {
    isInSplashScreen(value);
  }

  initApp() {
    setIsInSplashScreen(true);
    Future.delayed(Duration(seconds: 5), () {
      initLocale();
      var onboarded = box.read<bool>('onboarding') ?? false;
      var loggedIn = box.read<String>('token');
      if(loggedIn != null){
        Get.offNamed('/connexion');
      } else if(onboarded){
        Get.offNamed('/connexion');
      } else {
        Get.offNamed('/onboarding');
      }

    });
    setIsInSplashScreen(false);
  }

  initLocale() {
    GetStorage box = GetStorage();
    if (box.read('locale') != null)
      box.read('locale') == 'en_US'
          ? Get.updateLocale(Locale('fr', 'FR'))
          : Get.updateLocale(Locale('en', 'US'));
  }

  void navigateBack() => Get.back();
}