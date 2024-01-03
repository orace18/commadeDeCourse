import 'package:flutter/material.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/models/engin_card.dart';

class VehicleSelectionDialog extends StatelessWidget {
  late String selectedEnginType; // Variable pour stocker le type d'engin sélectionné

  @override
  Widget build(BuildContext context) {
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
              selectedEnginType = 'Moto'; // Affectez le type d'engin sélectionné
              Navigator.pop(context, selectedEnginType);
            },
          ),
          SizedBox(height: 8),
          VehicleCard(
            title: 'Voiture',
            icon: Icons.directions_car,
            onTap: () {
              selectedEnginType = 'Voiture'; // Affectez le type d'engin sélectionné
              Navigator.pop(context, selectedEnginType);
            },
          ),
          SizedBox(height: 8),
          VehicleCard(
            title: 'Tricycle',
            icon: Icons.directions_bike,
            onTap: () {
              selectedEnginType = 'Tricycle'; // Affectez le type d'engin sélectionné
              Navigator.pop(context, selectedEnginType);
            },
          ),
        ],
      ),
    );
  }
}
