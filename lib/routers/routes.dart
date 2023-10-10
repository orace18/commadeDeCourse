import 'package:get/get.dart';

import '../pages/home_page/controllers/home_binding.dart';
import '../pages/home_page/index.dart';
import '../pages/splash_page/controllers/splash_binding.dart';
import '../pages/splash_page/index.dart';

class AppRouter {
  static var routes = [
    GetPage(
      name: '/',
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/splash',
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
  ];
}