import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otrip/constants.dart';

class LocationPickerController extends GetxController {
  TextEditingController startLocationController = TextEditingController();
  TextEditingController endLocationController = TextEditingController();

  Future<List<String>> getPlaces(String query) async {
    try {
      final baseUrl =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';

      final response = await http.get(Uri.parse('$baseUrl?input=$query&key=$google_api_key'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        if (data['predictions'] != null) {
          List<dynamic> predictions = data['predictions'];

          return predictions.map<String>((prediction) {
            return prediction['description'] as String;
          }).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Erreur lors de la récupération des lieux : $error ');
      return [];
    }
  }
}
