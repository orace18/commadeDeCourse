import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/providers/theme/theme.dart';
import 'package:get_storage/get_storage.dart';


class DashboardGridView extends StatelessWidget {
  final userData = GetStorage();
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
        buildGridItem("Moto".tr, Icons.directions_bike, () {
          userData.write('engin', 'Moto');
          Get.toNamed('/addresse_choose');
        }),
        buildGridItem("Tricycle".tr, Icons.electric_bike_sharp, () {
          userData.write('engin', 'Tricycle');
          Get.toNamed('/addresse_choose');
        }),
        buildGridItem("activities".tr, Icons.access_time, () {
          Get.toNamed('/activities');
        }),
        buildGridItem("ride".tr, Icons.rice_bowl_rounded, () {
          Get.toNamed('/my_course');
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
