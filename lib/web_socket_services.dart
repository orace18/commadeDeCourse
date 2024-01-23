/* /* import 'package:get/get.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class WebSocketController extends GetxController {
  late WebSocketChannel _channel;
  late Timer _timer;
  late RxString _userPosition;

  @override
  void onInit() {
    super.onInit();
    _userPosition = ''.obs;

    // Remplacez 'userId' par l'ID réel de l'utilisateur
    String userId = '123';

    // Créer la connexion WebSocket
    _channel = WebSocketChannel.connect(
      Uri.parse(socketUrl),
    );

    // Écouter les messages du serveur
    _channel.stream.listen(
      (message) {
        print('Received: $message');
        // Mettez à jour l'interface utilisateur avec les données reçues si nécessaire
      },
      onDone: () {
        print('WebSocket channel closed');
        // Gérer la fermeture de la connexion si nécessaire
      },
      onError: (error) {
        print('Error: $error');
        // Gérer les erreurs de connexion si nécessaire
      },
    );

    // Définir une mise à jour périodique toutes les 5 minutes
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      // Envoyer l'ID de l'utilisateur avec sa position
      _sendUserPosition(userId);
    });
  }

  // Envoyer des données au serveur
  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  // Envoyer la position de l'utilisateur au serveur avec l'ID
  Future<void> _sendUserPosition(String userId) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final currentPosition =
          'id: $userId, latitude: ${position.latitude}, longitude: ${position.longitude}';
      _userPosition.value = currentPosition;
      sendMessage(currentPosition);
    } catch (e) {
      print('Error getting user position: $e');
      // Gérer les erreurs de récupération de la position si nécessaire
    }
  }

  @override
  void onClose() {
    // Fermer la connexion WebSocket lorsque le contrôleur est détruit
    _channel.sink.close();
    _timer.cancel(); // Annuler le timer
    super.onClose();
  }
}
 */

/* 
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:workmanager/workmanager.dart';

class WebSocketController extends GetxController {
  late WebSocketChannel _channel;

  @override
  void onInit() {
    super.onInit();
    // Créer la connexion WebSocket
    _channel = WebSocketChannel.connect(
      Uri.parse('YOUR_WEBSOCKET_URL'),
    );

    // Planifiez une tâche périodique toutes les 5 minutes
    schedulePeriodicTask();
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  // Planifiez une tâche périodique toutes les 5 minutes
  void schedulePeriodicTask() {
    Workmanager().registerOneOffTask(
      "1", // ID unique de la tâche
      "sendUserPositionTask", // Nom de la tâche
      frequency: Duration(minutes: 5),
      inputData: <String, dynamic>{},
    );
  }

  // Envoyer la position de l'utilisateur au serveur avec l'ID
  Future<void> sendUserPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final currentPosition =
          'latitude: ${position.latitude}, longitude: ${position.longitude}';
      sendMessage(currentPosition);
    } catch (e) {
      print('Error getting user position: $e');
    }
  }

  @override
  void onClose() {
    _channel.sink.close();
    super.onClose();
  }
}
 */

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:geolocator/geolocator.dart';

class WebSocketController extends GetxController {
  late WebSocketChannel _channel;
  final duree = 2;

  @override
  void onInit() {
    super.onInit();
    // Créer la connexion WebSocket
    _channel = WebSocketChannel.connect(
      Uri.parse(socketUrl),
    );

    // Planifiez une tâche périodique toutes les 5 minutes
    schedulePeriodicTask();
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  // Planifiez une tâche périodique toutes les 5 minutes
  void schedulePeriodicTask() {
    BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: duree, // Intervalle minimal de 5 minutes
        stopOnTerminate: false,
        enableHeadless: true,
        startOnBoot: true,
      ),
      (taskId) async {
        sendUserPosition();
        BackgroundFetch.finish(taskId);
      },
      (String taskId) {
        // Gestion des erreurs ici
      },
    );
  }

  // Envoyer la position de l'utilisateur au serveur avec l'ID
  Future<void> sendUserPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final currentPosition =
          'id: ${getUserId()}, latitude: ${position.latitude}, longitude: ${position.longitude}';
      sendMessage(currentPosition);
    } catch (e) {
      print('Error getting user position: $e');
    }
  }

  // Remplacez ceci par la logique réelle pour obtenir l'ID de l'utilisateur
  String getUserId() {
    final userId = GetStorage().read('id');
    return userId;
  }

  @override
  void onClose() {
    _channel.sink.close();
    BackgroundFetch.stop();
    super.onClose();
  }
}
 */