import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/api/conduteur/models/driver_list.dart';


class DriverService {

  Future<List<Driver>> getAllDriver() async {
    try {
      final response = await http.get(Uri.parse(driverUrl));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data') &&
            responseData['data'] is Map<String, dynamic> &&
            responseData['data'].containsKey('users')) {

          List<Driver> drivers = (responseData['data']['users'] as List)
              .map<Driver>((json) => Driver.fromJson(json))
              .where((driver) =>
                  driver.firstname != null &&
                  driver.lastname != null &&
                  driver.phoneNumber != null)
              .toList();

          print('Fetched drivers: $drivers');

          return drivers;
        } else {
          throw Exception('Invalid response format. Missing or incorrect list key.');
        }
      } else {
        throw Exception('Failed to load drivers. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching drivers: $error');
      throw Exception('Error fetching drivers: $error');
    }
  }
}

