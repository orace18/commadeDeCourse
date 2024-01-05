import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/legalmention_page/widgets/course_moto.dart';
import 'package:otrip/pages/legalmention_page/widgets/course_tricycle.dart';
import 'package:otrip/pages/legalmention_page/widgets/course_voiture.dart';

import 'package:otrip/providers/theme/theme.dart';

class DashboardGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      padding: EdgeInsets.all(16.0),
      children: [
        buildGridItem("Voiture".tr, Icons.directions_car, () async {
          Get.dialog(VoitureLocationPickerView());
        }),
        buildGridItem("Moto".tr, Icons.directions_bike, () {
          Get.dialog(MotoLocationPickerView());

        }),
        buildGridItem("Tricycle".tr, Icons.electric_bike_sharp, () {
          Get.dialog(TricycleLocationPickerView());

        }),
        buildGridItem("activities".tr, Icons.access_time, () {
          Get.toNamed('/activities');
        }),
        buildGridItem("ride".tr, Icons.rice_bowl_rounded, () {
          Get.toNamed('/course');
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
