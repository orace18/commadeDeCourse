import 'package:location/location.dart';

class UserLocation {
  final Location _location = Location();
  Map<String, double> location = {};

  Future<Map<String, double?>> getPostion() async {
    try {
      var currentLocation = await _location.getLocation();
      print(
          "Latitude: ${currentLocation.latitude}, Longitude: ${currentLocation.longitude}");
      return {
        'longitude': currentLocation.longitude,
        'latitude': currentLocation.latitude,
      };
    } catch (e) {
      print("Erreur: $e");

      return {'longitude': 0.0, 'latitude': 0.0};
    }
  }
}
