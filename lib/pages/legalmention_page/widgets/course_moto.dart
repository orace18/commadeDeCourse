import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/legalmention_page/controllers/legalmention_controller.dart';

class MotoLocationPickerView extends GetView<LocationPickerController> {
  MotoLocationPickerView({Key? key}) : super(key: key);
  final LocationPickerController controller =
      Get.put(LocationPickerController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 190,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.startLocationController,
                          decoration: InputDecoration(labelText: 'Départ'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Action pour choisir le départ sur la carte
                          // Ajoutez la logique nécessaire ici
                        },
                        child: Text('Choisir sur la carte'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.endLocationController,
                          decoration: InputDecoration(labelText: 'Arrivée'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Action pour choisir l'arrivée sur la carte
                          // Ajoutez la logique nécessaire ici
                        },
                        child: Text('Choisir sur la carte'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Annuler'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Action pour la sélection de conducteur
                          Get.toNamed('/moto');
                        },
                        child: Text('Choisir un conducteur'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
