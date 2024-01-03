import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/api/conduteur/models/driver_list.dart';
import 'package:http/http.dart' as http;

class SpecificDriverController extends GetxController {
  List<Map<String, dynamic>> driverList = [];

  Future<List<Map<String, dynamic>>> fetchSpecificDriver(String engin) async {
    try {
      final response = await http.get(Uri.parse('$driverByEngin/$engin'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = json.decode(response.body);

      if (responseData is List<dynamic> && responseData.isNotEmpty) {
        List<Map<String, dynamic>> driverList = List<Map<String, dynamic>>.from(responseData);
        return driverList;
      } else {
        throw Exception('Invalid response format for users by engin type.');
      }
      } else {
        throw Exception(
            'Erreur lors du chargement de la liste : ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Une Erreur s\'est produite: $error');
    }

    return [];
  }

  
}
