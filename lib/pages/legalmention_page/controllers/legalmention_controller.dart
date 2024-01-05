import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'package:otrip/constants.dart';

class LocationPickerController extends GetxController {
  TextEditingController startLocationController = TextEditingController();
  TextEditingController endLocationController = TextEditingController();
 // late GoogleMapController googleMapController;
  //List<String> listPlace = [];

  /* final LatLng defaultLatLng =
      LatLng(6.359201, 2.418710); // Coordonnées par défaut (Cotonou)

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  } */

  void chooseLocation() {
    print('Départ : ${startLocationController.text}');
    print('Arrivée : ${endLocationController.text}');
    Get.back();
  }
/* 
  Future<List<String>> getPlaces(String query) async {
    final baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';

    try {
      final response = await Dio().get(
        baseUrl,
        queryParameters: {
          'input': query,
          'key': google_api_key,
        },
      );

      if (response.statusCode == 200) {
        final predictions = response.data['predictions'] as List<dynamic>;

        listPlace = predictions
            .map((prediction) => prediction['description'].toString())
            .toList();
        print('La liste: $listPlace');
        return listPlace;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } on DioError catch (dioError) {
      // DioError est déjà capturé, vous pouvez le gérer ici
      print('Erreur Dio lors de la récupération des lieux : $dioError');
      return [];
    } catch (error) {
      print('Erreur lors de la récupération des lieux : $error');
      return [];
    }
  } */
}
