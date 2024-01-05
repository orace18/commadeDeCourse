import 'package:otrip/api/api_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  // Initialise la connexion au serveur
  void initializeSocket() {
    // Remplacez '$baseUrl' par la véritable adresse de serveur
    socket = IO.io('$baseUrl', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
  }

  // Envoie une notification au serveur
  void sendNotification() {
    socket.emit('sendNotification', {'message': 'Hello from Otrip!'});
  }

  // Écoute les notifications du serveur
  void listenForNotifications(Function(dynamic) onNotificationReceived) {
    socket.on('notification', (data) {
      onNotificationReceived(data);
    });
  }

  // Déconnexion du serveur
  void disconnectSocket() {
    socket.disconnect();
  }
}
