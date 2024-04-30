import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocationPickerController extends GetxController {
  TextEditingController startLocationController = TextEditingController();
  TextEditingController endLocationController = TextEditingController();
  final storage = GetStorage();
  double distanceInKm = 0.0;
  double prix = 0.0;

/*@override
  void onInit() {
    super.onInit();
    // Charger les emplacements sauvegardés lors de l'initialisation du contrôleur
    loadSavedLocations();
  }
 */

  Future<Location?> getLocationFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return locations.first;
      }
    } catch (e) {
      print("Error getting location: $e");
    }
    return null;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }



  Future<void> adrLocations() async {
    Location? startLocation = await getLocationFromAddress(startLocationController.text);
    Location? endLocation = await getLocationFromAddress(endLocationController.text);
    if (startLocation != null && endLocation != null) {
      LatLng departure = LatLng(startLocation.latitude, startLocation.longitude);
      LatLng destination = LatLng(endLocation.latitude, endLocation.longitude);
      print("Départ: ${departure.latitude}, ${departure.longitude}");
      print("Arrivée: ${destination.latitude}, ${destination.longitude}");
      _showDistance(departure, destination);
    }
  }

  void _showDistance(LatLng departure, LatLng destination) {
    double distance = Geolocator.distanceBetween(departure!.latitude!, departure!.longitude!, destination!.latitude!, destination!.longitude!);
    distanceInKm = distance / 1000;
    prix = CalculateCourseCost(distanceInKm, prixDuKm);
    GetStorage().write('prix', prix);
    GetStorage().write('distance', distanceInKm);
    print("Montant : $prix");
    print("Distance: ${distanceInKm.toStringAsFixed(2)} km");
  }


  Future<List<String>> getPlaces(String query) async {
    try {
      final baseUrl =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';

      final response = await http
          .get(Uri.parse('$baseUrl?input=$query&key=$google_api_key'));

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

  Map<String, dynamic> getStorage() {
    return {'engin': storage.read('engin')};
  }

  void loadSavedLocations() {
    // Charger les emplacements sauvegardés depuis Get Storage
    final startLocation = storage.read('startLocation');
    final endLocation = storage.read('endLocation');
    final engin = storage.read('engin');

    // Mettre à jour les contrôleurs avec les valeurs sauvegardées
    startLocationController.text = startLocation ?? '';
    endLocationController.text = endLocation ?? '';
  }

  void saveLocations() {
    // Enregistrer les emplacements dans Get Storage
    storage.write('startLocation', startLocationController.text);
    storage.write('endLocation', endLocationController.text);
  }

  bool checkLocation(){
    if(startLocationController.text == null && endLocationController.text == null){
      return false;
    }else{
      return true;
    }
  }

  Future<bool> makeCourse(String engin, String addressStart, String addressEnd,
      String id_passager, String id_conducteur) async {
        final montant = GetStorage().read('prix');
        final distance = GetStorage().read('distance');
        print("la distance est $distance et le prix est : $montant");
        String body = jsonEncode({
        'type_engin': engin,
        'depart': addressStart,
        'arrivee': addressEnd,
        'montant': montant,
        'distance': distance,
        'idPassager': id_passager,
        'users_id': id_conducteur,
      });

    try {
      final response = await http.post(Uri.parse(makeCourseUrl), body: body, headers: {
        'Content-Type': 'application/json'
      });

      print('Le body est: $body');
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);
        returnSuccess(res['message']);
        print('Course fait');
        return true;
      } else {
        final res = jsonDecode(response.body);
        returnError(res['message']);
        print('Course non fait code status:${response.statusCode}');
        return false;
      }
    } catch (e) {
      throw Exception("Error durring course making: $e");
    }
  }

  sendNotif() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
 
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/otrip_logo');
 
/*     const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    ); */

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
     // iOS: initializationSettingsIOS,
    );
 
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
 
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high channel',
      'Very important notification!!',
      description: 'the first notification',
      importance: Importance.max,
    );
 
    await flutterLocalNotificationsPlugin.show(
      1,
      'Une course',
      'Je veux commander une course',
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description),
      ),
    );
  }
}
