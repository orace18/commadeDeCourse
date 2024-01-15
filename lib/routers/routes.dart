import 'package:get/get.dart';
import 'package:otrip/pages/add_user_page/controllers/add_user_binding.dart';
import 'package:otrip/pages/add_user_page/index.dart';
import 'package:otrip/pages/assistance_page/controllers/assistance_binding.dart';
import 'package:otrip/pages/assistance_page/index.dart';
import 'package:otrip/pages/connexion_page/index.dart';
import 'package:otrip/pages/course_page/controllers/course_binding.dart';
import 'package:otrip/pages/course_page/index.dart';
import 'package:otrip/pages/dashboard_page/dashboards/driver_page/widgets/driver_menu.dart';
import 'package:otrip/pages/dashboard_page/dashboards/marchand_page/widgets/machand_menu.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/controllers/passager_binding.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/index.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/widgets/passager_menu.dart';
import 'package:otrip/pages/engin_page/widgets/moto_drivers_list.dart';
import 'package:otrip/pages/engin_page/widgets/tricyle_drivers_list.dart';
import 'package:otrip/pages/engin_page/widgets/voiture_drivers_list.dart';
import 'package:otrip/pages/legalmention_page/controllers/legalmention_controller.dart';
import 'package:otrip/pages/legalmention_page/widgets/course.dart';
import 'package:otrip/pages/legalmention_page/widgets/course_map.dart';
import 'package:otrip/pages/liste_page/marchand_liste_page/index.dart';
import 'package:otrip/pages/liste_page/passager_liste_page/controllers/specific_drivers_binding.dart';
import 'package:otrip/pages/liste_page/passager_liste_page/index.dart';
import 'package:otrip/pages/map_page/controllers/map_binding.dart';
import 'package:otrip/pages/map_page/index.dart';
import 'package:otrip/pages/newMap_page/controllers/newMap_binding.dart';
import 'package:otrip/pages/newMap_page/index.dart';
import 'package:otrip/pages/notifications_page/controllers/notification_binding.dart';
import 'package:otrip/pages/notifications_page/index.dart';
import 'package:otrip/pages/onboarding_page/controllers/onboarding_binding.dart';
import 'package:otrip/pages/onboarding_page/index.dart';
import 'package:otrip/pages/connexion_page/controllers/connexion_binding.dart';
import 'package:otrip/pages/parrainage_demange_page/controllers/parrainage_demande_binding.dart';
import 'package:otrip/pages/parrainage_demange_page/index.dart';
import 'package:otrip/pages/passager_demande_page/controllers/passager_demande_bindings.dart';
import 'package:otrip/pages/passager_demande_page/index.dart';
import 'package:otrip/pages/profile_edit_company_page/controllers/profile_edit_company_binding.dart';
import 'package:otrip/pages/profile_edit_company_page/index.dart';
import 'package:otrip/pages/profile_edit_contact_address_page/controllers/profile_edit_contact_address_binding.dart';
import 'package:otrip/pages/profile_edit_contact_address_page/index.dart';
import 'package:otrip/pages/profile_edit_info_page/controllers/profile_edit_info_binding.dart';
import 'package:otrip/pages/profile_edit_info_page/index.dart';
import 'package:otrip/pages/profile_edit_info_page/profileConducteur_edit.dart';
import 'package:otrip/pages/profile_edit_info_page/profileMarchand_edit.dart';
import 'package:otrip/pages/profile_edit_seats_page/controllers/profile_edit_seats_binding.dart';
import 'package:otrip/pages/profile_edit_seats_page/index.dart';
import 'package:otrip/pages/profile_page/conducteur_profile.dart';
import 'package:otrip/pages/profile_page/controllers/conducteur_binding.dart';
import 'package:otrip/pages/profile_page/controllers/marchand_binding.dart';
import 'package:otrip/pages/profile_page/passager_profile.dart';
import 'package:otrip/pages/profile_page/marchand_profile.dart';
import 'package:otrip/pages/role_choose_page/controllers/role_choose_binding.dart';
import 'package:otrip/pages/dashboard_page/dashboards/driver_page/controllers/driver_binding.dart';
import 'package:otrip/pages/dashboard_page/dashboards/driver_page/index.dart';
import 'package:otrip/pages/role_choose_page/index.dart';
import 'package:otrip/pages/dashboard_page/dashboards/marchand_page/controller/marchand_binding.dart';
import 'package:otrip/pages/dashboard_page/dashboards/marchand_page/index.dart';
import 'package:otrip/pages/liste_page/conducteur_liste_page/controllers/parrainage_list_conducteur_binding.dart';
import 'package:otrip/pages/role_page/controllers/role_binding.dart';
import 'package:otrip/pages/role_page/index.dart';
import 'package:otrip/pages/liste_page/conducteur_liste_page/index.dart';
import 'package:otrip/pages/selecte_place_page/controllers/search_place_binding.dart';
import 'package:otrip/pages/selecte_place_page/index.dart';
import 'package:otrip/pages/settings_page/controllers/settings_binding.dart';
import 'package:otrip/pages/settings_page/index.dart';
import 'package:otrip/pages/support_page/controllers/support_binding.dart';
import 'package:otrip/pages/support_page/index.dart';
import 'package:otrip/pages/track_user_map_page/controllers/user_track_binding.dart';
import 'package:otrip/pages/track_user_map_page/index.dart';
import 'package:otrip/pages/wallet_page/controllers/wallet_binding.dart';
import 'package:otrip/pages/wallet_page/index.dart';
import 'package:otrip/pages/wallet_recharge_page/controllers/wallet_recharge_binding.dart';
import 'package:otrip/pages/wallet_recharge_page/index.dart';

import '../pages/login_page/controllers/login_binding.dart';
import '../pages/login_page/index.dart';
import '../pages/otp_page/index.dart';
import '../pages/profile_edit_info_page/controllers/profile_edit_conducteur_binding.dart';
import '../pages/profile_edit_info_page/controllers/profile_edit_marchand_binding.dart';
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
import '../pages/splash_page/controllers/splash_binding.dart';
import '../pages/splash_page/index.dart';

class AppRouter {
  static var routes = [
    GetPage(
      name: '/',
      page: () => HomePage(),
      bindings: [
        HomeBinding(),
        DashboardBinding(),
        ActivitiesBinding(),
        CustomersBinding(),
        ProfileBinding()
      ],
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
      name: '/add_user',
      page: () => AddUserPage(),
      binding: AddUserBinding(),
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
    GetPage(
      name: '/onboarding',
      page: () => OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: '/settings',
      page: () => SettingsPage(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: '/support',
      page: () => SupportPage(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: '/role',
      page: () => RolePage(),
      binding: RoleBinding(),
    ),
    GetPage(
      name: '/profile_edit_company',
      page: () => ProfileEditCompanyPage(),
      binding: ProfileEditCompanyBinding(),
    ),
    GetPage(
      name: '/profile_edit_contact_address',
      page: () => ProfileEditContactAddressPage(),
      binding: ProfileEditContactAddressBinding(),
    ),
    GetPage(
      name: '/profile_edit_info',
      page: () => ProfileEditInfoPage(),
      binding: ProfileEditInfoBinding(),
    ),
    GetPage(
      name: '/profile_edit_seat',
      page: () => ProfileEditSeatsPage(),
      binding: ProfileEditSeatsBinding(),
    ),
    GetPage(
      name: '/map',
      page: () => MapPage(),
      binding: MapBinding(),
    ),
    GetPage(
      name: '/wallet',
      page: () => WalletPage(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: '/wallet_recharge',
      page: () => WalletRechargePage(),
      binding: WalletRechargeBinding(),
    ),
    GetPage(
      name: '/new_map',
      page: () => NewMapPage(),
      binding: NewMapBinding(),
    ),
    GetPage(
      name: '/role_choose',
      page: () => RoleChoosePage(),
      binding: RoleChooseBinding(),
    ),
    GetPage(
      name: '/marchand',
      page: () => MarchandPage(),
      binding: MarchandBinding(),
    ),
    GetPage(
      name: '/demande_conducteur',
      page: () => DemandePage(),
      binding: DemandeBinding(),
    ),
    GetPage(
      name: '/assistance',
      page: () => AssistancePage(),
      binding: AssistanceBinding(),
    ),
    GetPage(
      name: '/listConducteur',
      page: () => ListConducteurPage(),
      binding: ListConducteurBinding(),
    ),
    GetPage(
      name: '/driver',
      page: () => DriverPage(),
      binding: DriverBinding(),
    ),
    GetPage(
      name: '/passager',
      page: () => PassagerPage(),
      binding: PassagerBinding(),
    ),
    GetPage(
      name: '/notification',
      page: () => NotificationPage(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: '/demande_passager',
      page: () => PassagerDemandePage(),
      binding: PassagerDemandeBinding(),
    ),
    GetPage(
      name: '/course',
      page: () => CoursePage(),
      binding: CourseBinding(),
    ),
    GetPage(
      name: '/driver_menu',
      page: () => DriverMenu(),
    ),
    GetPage(
      name: '/marchand_menu',
      page: () => MarchandMenu(),
    ),
    GetPage(
      name: '/passager_menu',
      page: () => PassagerMenu(),
    ),
    GetPage(
      name: '/profile_marchand',
      page: () => MarchandProfilePage(),
      binding: MerchantProfileBinding(),
    ),
    GetPage(
      name: '/profile_conducteur',
      page: () => DriverProfilePage(),
      binding: DriverProfileBinding(),
    ),
    GetPage(
      name: '/profile_edit_marchand',
      page: () => ProfileEditMerchantPage(),
      binding: ProfileEditMarchandBinding(),
    ),
    GetPage(
      name: '/profile_edit_conducteur',
      page: () => ProfileEditDriverPage(),
      binding: ProfileEditDriverBinding(),
    ),
    GetPage(
      name: '/parrainage',
      page: () => MarchandListPage(),
    ),
    GetPage(
      name: '/specific_driver',
      page: () => SpecificDriverPage(),
      binding: SpecificDriverBinding(),
    ),
    GetPage(
      name: '/moto',
      page: () => MotoDriversPage( enginType: 'Moto'),
    ),
    GetPage(
      name: '/voiture',
      page: () => VoitureDriversPage(enginType: 'Voiture'),
    ),
    GetPage(
      name: '/tricycle',
      page: () => TricycleDriversPage( enginType: 'Tricycle'), 
    ),
    GetPage(
      name: '/addresse_choose',
      page: () => LocationPage(), 
    ),
    GetPage(
      name: '/quartier',
      page: () => NeighborhoodsPage(),
     binding: NeighborhoodsBinding(),
    ),
        GetPage(
      name: '/course_map',
      page: () => CourseMapPage(),
    ),
    GetPage(
      name: '/track_user',
      page: () => TrackMapPage(),
     binding: TrackMapBinding(),
    ),
  ];
}
