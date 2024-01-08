import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/legalmention_page/controllers/legalmention_controller.dart';

class LocationTextField extends StatelessWidget {
  final String title;
  final LocationPickerController controller;

  LocationTextField({required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextField(
          controller: (title == 'Départ') ? controller.startLocationController : controller.endLocationController,
          onChanged: (query) async {
            List<String> suggestions = await controller.getPlaces(query);
            if (suggestions.isNotEmpty) {
              showLocationSuggestions(suggestions, context);
            }
          },
        ),
      ],
    );
  }

  void showLocationSuggestions(List<String> suggestions, BuildContext context) {
    Get.bottomSheet(
      ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestions[index]),
            onTap: () {
              // Ajoutez ici la logique pour sélectionner le lieu
              Get.back();
            },
          );
        },
      ),
    );
  }
}


class LocationPage extends StatelessWidget {
  final LocationPickerController controller = Get.put(LocationPickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choix de lieu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LocationTextField(
              title: 'Départ',
              controller: controller,  // Utilisez le même contrôleur ici
            ),
            SizedBox(height: 20),
            LocationTextField(
              title: 'Arrivée',
              controller: controller,  // Utilisez le même contrôleur ici
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique pour ajouter une carte
              },
              child: Text('Add Map'),
            ),
          ],
        ),
      ),
    );
  }
}
