import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/receive_message_page/index.dart';
import 'package:otrip/providers/theme/theme.dart';
import 'package:get_storage/get_storage.dart';



class DashboardGridView extends StatelessWidget {
  final userData = GetStorage();
  String id = GetStorage().read('id').toString();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      padding: EdgeInsets.all(16.0),
      children: [
        buildGridItem("Voiture".tr, Icons.directions_car, () async {
          userData.write('engin', 'Voiture');
          Get.toNamed('/addresse_choose');
        }),
        buildGridItem("Moto".tr, Icons.two_wheeler, () {
          userData.write('engin', 'Moto');
          Get.toNamed('/addresse_choose');
        }),
        buildGridItem("Tricycle".tr, Icons.bike_scooter, () {
          userData.write('engin', 'Tricycle');
          Get.toNamed('/addresse_choose');
        }),
        buildGridItem("Bus".tr, Icons.directions_bus, () {
          Get.toNamed('/bus_societe');
        }),
        buildGridItem("activities".tr, Icons.pending_actions, () {
          Get.toNamed('/activities');
        }),
         buildGridItem("message".tr, Icons.message, () {
          Get.to(ReceiveMessagePage(receiverid: id));
        }),
      ],
    );
  }

  Widget buildGridItem(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48.0,
              color: AppTheme.otripMaterial[500],
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
