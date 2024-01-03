import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/models/engin_card.dart';
import 'package:otrip/pages/liste_page/passager_liste_page/index.dart';
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
        buildGridItem("Trouver un conducteur", Icons.directions_car, () async {
          final selectedEnginType = await showVehicleSelectionDialog(context);
          if (selectedEnginType != null) {
            Get.to(SpecificDriverPage(selectedEnginType));
            print('Type d\'engin sélectionné : $selectedEnginType');
          }
        }),
        buildGridItem("ride".tr, Icons.access_time, () {
          Get.toNamed('/course');
        }),
        buildGridItem("activities".tr, Icons.access_time, () {
          Get.toNamed('/activities');
        }),
        buildGridItem("profil".tr, Icons.access_time, () {
          Get.toNamed('/profile');
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

  Future<String?> showVehicleSelectionDialog(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sélectionnez un véhicule'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              VehicleCard(
                title: 'Moto',
                icon: Icons.motorcycle,
                onTap: () {
                  Navigator.pop(context, 'Moto');
                },
              ),
              SizedBox(height: 8),
              VehicleCard(
                title: 'Voiture',
                icon: Icons.directions_car,
                onTap: () {
                  Navigator.pop(context, 'Voiture');
                },
              ),
              SizedBox(height: 8),
              VehicleCard(
                title: 'Tricycle',
                icon: Icons.directions_bike,
                onTap: () {
                  Navigator.pop(context, 'Tricycle');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
