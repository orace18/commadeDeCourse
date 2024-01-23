import 'dart:convert';

import 'package:otrip/api/api_constants.dart';
import 'package:otrip/api/conduteur/models/driver_list.dart';
import 'package:http/http.dart' as http;

class DriverService {
  Future<List<Driver>> getAllDrivers() async {
    try {
      final response = await http.get(Uri.parse(driverUrl));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = json.decode(response.body);

        // Ajout de logs pour afficher la réponse brute de l'API
        print('Raw API response: $responseData');

        if (responseData['success'] == true &&
            responseData.containsKey('data') &&
            responseData['data'] is Map<String, dynamic> &&
            responseData['data'].containsKey('users') &&
            responseData['data']['users'] is List<dynamic>) {
          List<Driver> drivers =
              (responseData['data']['users'] as List<dynamic>)
                  .map<Driver>((json) => Driver.fromJson(json))
                  .toList();
          print('Les drivers sont ${drivers}');
          return drivers;
        } else {
          throw Exception(
              'Invalid response format. Missing or incorrect keys.');
        }
      } else {
        throw Exception(
            'Failed to load drivers. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching drivers: $error');
    }
  }


}
