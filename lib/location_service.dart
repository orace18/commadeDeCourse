import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<LocationData?> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Vérifiez si le service de localisation est activé
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Demandez la permission si nécessaire
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    // Récupérez et retournez la position actuelle
    return await location.getLocation();
  }

  Stream<LocationData> get locationStream => location.onLocationChanged;
}
