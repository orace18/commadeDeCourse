import 'package:get/get.dart';
import 'package:otrip/pages/connexion_page/controllers/connexion_binding.dart';
import 'package:otrip/pages/connexion_page/index.dart';
import '../pages/login_page/controllers/login_binding.dart';
import '../pages/login_page/index.dart';
import '../pages/otp_page/index.dart';
import '../pages/register_page/controllers/register_binding.dart';
import '../pages/register_page/index.dart';
import '../pages/activities_page/controllers/activities_binding.dart';
import '../pages/activities_page/index.dart';
import '../pages/customers_page/controllers/customers_binding.dart';
import '../pages/customers_page/index.dart';
import '../pages/dashboard_page/controllers/dashboard_binding.dart';
import '../pages/dashboard_page/index.dart';
import '../pages/home_page/controllers/home_binding.dart';
import '../pages/home_page/index.dart';
import '../pages/otp_page/controllers/otp_binding.dart';
import '../pages/profile_page/controllers/profile_binding.dart';
import '../pages/profile_page/index.dart';
import '../pages/splash_page/controllers/splash_binding.dart';
import '../pages/splash_page/index.dart';

class AppRouter {
  static var routes = [
    GetPage(
      name: '/',
      page: () => HomePage(),
      bindings: [HomeBinding(), DashboardBinding(), ActivitiesBinding(), CustomersBinding(), ProfileBinding()],
    ),
    GetPage(
      name: '/splash',
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/connexion',
      page: () => ConnexionPage(),
      binding: ConnexionBinding(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: '/otp',
      page: () => OtpPage(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: '/splash',
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: '/activities',
      page: () => ActivitiesPage(),
      binding: ActivitiesBinding(),
    ),
    GetPage(
      name: '/customers',
      page: () => CustomersPage(),
      binding: CustomersBinding(),
    ),
    GetPage(
      name: '/profile',
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
  ];
}