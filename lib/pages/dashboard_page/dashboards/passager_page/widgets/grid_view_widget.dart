// grid_view_widget.dart
import 'package:flutter/material.dart';

class DashboardGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // Nombre de colonnes dans le GridView
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      padding: EdgeInsets.all(16.0),
      children: [
        buildGridItem("Trouver un conducteur", Icons.directions_car, () {
          // Mettez votre logique ici pour l'action du bouton
        }),
        buildGridItem("Autre élément", Icons.access_time, () {
          // Mettez votre logique ici pour l'action du bouton
        }),
        // Ajoutez plus d'éléments au besoin
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
              color: Colors.blue,
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
