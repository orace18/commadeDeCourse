import 'package:flutter/material.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/widgets/engin_selecte.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/widgets/grid_view_widget.dart';
import 'package:otrip/pages/engin_page/index.dart';

class VehicleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  VehicleCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

 @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 50),
              SizedBox(height: 8),
              Text(title, style: TextStyle(fontSize: 16)),
            ],
          ),
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
  



