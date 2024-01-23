/* import 'dart:convert';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;




class BackgroundLocationService {
  String positionJson = '';

  @override
  void initState() {

    // Configuration de base pour le plugin
    bg.BackgroundGeolocation.ready(bg.Config(
      desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
      distanceFilter: 10.0,
      stopOnTerminate: false,
      startOnBoot: true,
      debug: true,
    ));

    // Initialiser le plugin
    bg.BackgroundGeolocation.start();

    // Écouter les mises à jour de position
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      // Convertir la position en JSON
      String jsonPosition = jsonEncode(location.toMap());
      
    });
  }


}
 */