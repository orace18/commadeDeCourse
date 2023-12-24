import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationController extends GetxController{
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  

    Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =

        AndroidNotificationDetails(
      'your channel id', 'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Titre de la notification',
      'Contenu de la notification',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}