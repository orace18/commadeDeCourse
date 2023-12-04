import 'package:location/location.dart';

class UserLocation {
  Location location = Location();
  late LocationData currentLocation;
  List<Map<String, dynamic>> positions = [];

  Future<List<Map<String, dynamic>>> trackLocation() async {
    try {
      currentLocation = await location.getLocation();
      Map<String, dynamic> mapPosition = {
        "Longitude": currentLocation.longitude,
        "Latitude": currentLocation.latitude,
      };
      positions.add(mapPosition);
      return positions;
    } catch (e) {
      print("Erreur: $e");
      return [];
    }
  }

  
}
