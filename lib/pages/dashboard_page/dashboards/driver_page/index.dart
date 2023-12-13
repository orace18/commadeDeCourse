import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverPage extends StatelessWidget {
  final int totalConducteurs =
      10; // Remplacez par votre nombre total de conducteurs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de Bord Marchant'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Nombre Total de Conducteurs: $totalConducteurs'),
          ),
          ListTile(
            title: Text('Liste des Conducteurs'),
            onTap: () {
              // Naviguez vers la page de la liste des conducteurs
              Get.toNamed('/listConducteur');
            },
          ),
          ListTile(
            title: Text('Les Demandes'),
            onTap: () {
              // Naviguez vers la page des demandes
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DemandesPage()),
              );
            },
          ),
          ListTile(
            title: Text('Statistiques'),
            onTap: () {
              // Naviguez vers la page des statistiques
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatistiquesPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Ajoutez d'autres pages (ConducteursListePage, DemandesPage, StatistiquesPage) avec leur contenu respectif.

class ConducteursListePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Conducteurs'),
      ),
      body: Center(
        child: Text('Contenu de la Liste des Conducteurs'),
      ),
    );
  }
}

class DemandesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Les Demandes'),
      ),
      body: Center(
        child: Text('Contenu des Demandes'),
      ),
    );
  }
}

class StatistiquesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistiques'),
      ),
      body: Center(
        child: Text('Contenu des Statistiques'),
      ),
    );
  }
}
