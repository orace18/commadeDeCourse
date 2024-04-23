//import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:otrip/pages/profile_page/controllers/conducteur_profile_controller.dart';
import 'package:otrip/pages/profile_page/controllers/profile_controller.dart';
import 'package:otrip/pages/profile_page/controllers/profile_marchand_controller.dart';
import 'package:otrip/web_socket_and%20_Location_services.dart';
import 'package:workmanager/workmanager.dart';
import 'providers/theme/theme.dart';
import 'providers/theme/theme_provider.dart';
import 'routers/routes.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import 'local_lang/translator.dart';

void main() async {
  Get.put(ProfileController());
  Get.put(MerchantController());
  Get.put(ConducteurProfileController());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await GetStorage.init();
  //BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

   /* Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false, // Mettez à true en mode de débogage
  ); */
  runApp(const MyApp());
}
/* void backgroundFetchHeadlessTask(String taskId) async {
  WebSocketController().sendUserPosition();
  BackgroundFetch.finish(taskId);
} */

/* void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // Exécutez la tâche à effectuer périodiquement ici
    WebSocketController().sendUserPosition();
    return Future.value(true);
  });
} */

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider();
    return GetMaterialApp(
      navigatorKey: Get.key,
      translations: Translator(),
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
      title: 'Otrip',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.theme,
      initialRoute: '/splash',
      getPages: AppRouter.routes,

      // supportedLocales: const [...FormBuilderLocalizations.supportedLocales],
      localizationsDelegates: const [
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
    );
  }
}
