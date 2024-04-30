import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/constants.dart';


class GoogleServiceOtrip {

 final Location _location = Location();

  Future<String?> getPlaceName(double? latitude, double? longitude) async {
    final response = await http.get(
      Uri.parse('$apiUrl?latlng=$latitude,$longitude&key=$google_api_key'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        final addressComponents =
            results[0]['address_components'] as List<dynamic>;
        final formattedAddress = results[0]['formatted_address'];
        print('Adresse: $formattedAddress');
        // Vous pouvez extraire d'autres informations à partir de addressComponents si nécessaire
        return formattedAddress;
      }
    }

    return null;
  }


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
