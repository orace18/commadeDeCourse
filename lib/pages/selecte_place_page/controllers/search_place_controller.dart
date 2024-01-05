import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/constants.dart';

class NeighborhoodsController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxList<String> neighborhoods = <String>[].obs;

  void searchNeighborhoods(String query) async {
 
    final response = await http.get(
      Uri.parse('$apiGooglePlace?input=$query&key=$google_api_key'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final predictions = data['predictions'] as List<dynamic>;

      neighborhoods.assignAll(predictions.map<String>((prediction) {
        return prediction['description'] as String;
      }));
    } else {
      print('Erreur lors de la recherche des quartiers.');
    }
  }
}
