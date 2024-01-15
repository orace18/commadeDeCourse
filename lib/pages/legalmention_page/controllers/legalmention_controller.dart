import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocationPickerController extends GetxController {
  TextEditingController startLocationController = TextEditingController();
  TextEditingController endLocationController = TextEditingController();
  final storage = GetStorage();

/*@override
  void onInit() {
    super.onInit();
    // Charger les emplacements sauvegardés lors de l'initialisation du contrôleur
    loadSavedLocations();
  }
 */
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

  Future<bool> makeCourse(String engin, String addressStart, String addressEnd,
      String id_passager, String id_conducteur) async {

        String body = jsonEncode({
        'engin': engin,
        'depart': addressStart,
        'arrivee': addressEnd,
        'idPassager': id_passager,
        'users_id': id_conducteur,
      });

    try {
      final response = await http.post(Uri.parse(makeCourseUrl), body: body, headers: {
        'Content-Type': 'application/json'
      });

      print('Le body est: $body');
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Course fait');
        return true;
      } else {
        print('Course non fait');
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
