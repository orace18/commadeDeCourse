import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanager/workmanager.dart';

class WebSocketController extends GetxController {
  late WebSocketChannel _channel;
  late RxString _userPosition;

  @override
  void onInit() {
    super.onInit();
    _userPosition = ''.obs;

    // Remplacez 'userId' par l'ID réel de l'utilisateur
    String userId = '123';

    // Créer la connexion WebSocket
    _channel = WebSocketChannel.connect(
      Uri.parse('YOUR_WEBSOCKET_URL'),
    );

    _channel.stream.listen(
      (message) {
        print('Received: $message');
      },
      onDone: () {
        print('WebSocket channel closed');
      },
      onError: (error) {
        print('Error: $error');
      },
    );

    // Planifiez une tâche périodique toutes les 5 minutes
    schedulePeriodicTask();
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  void schedulePeriodicTask() {
    Workmanager().registerOneOffTask(
      "1", // ID unique de la tâche
      "sendUserPositionTask", // Nom de la tâche
      initialDelay:  Duration(minutes: 5),
      inputData: <String, dynamic>{},
    );
  }

  Future<void> sendUserPositionTask() async {
    // Envoyer la position de l'utilisateur au backend
    await _sendUserPosition('123'); // Remplacez '123' par l'ID réel de l'utilisateur
    // Réinscrivez la tâche périodique
    schedulePeriodicTask();
  }

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
    }
  }

  @override
  void onClose() {
    _channel.sink.close();
    super.onClose();
  }
}
