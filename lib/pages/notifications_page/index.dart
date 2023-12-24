import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/notifications_page/controllers/notification_controller.dart';

class NotificationPage extends GetWidget<NotificationController> {
// Initialisation de la notification local
  final NotificationController controller = NotificationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            controller.showNotification();
          },
          child: Text('Afficher la notification'),
        ),
      ),
    );
  }
}
