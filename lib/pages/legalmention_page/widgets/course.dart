import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/pages/legalmention_page/controllers/legalmention_controller.dart';

class LocationTextField extends StatelessWidget {
  final String title;
  final LocationPickerController controller;

  LocationTextField({required this.title, required this.controller});

  void showLocationSuggestions(List<String> suggestions, BuildContext context,
      TextEditingController textEditingController) {
    Get.bottomSheet(ListView.builder(
      shrinkWrap: true,
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return Container(
          height: 50, // Hauteur fixe pour chaque élément
          child: ListTile(
            title: Text(suggestions[index]),
            onTap: () {
              textEditingController.text = suggestions[index];
              Get.back();
            },
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: (title == 'Départ')
                    ? controller.startLocationController
                    : controller.endLocationController,
                onChanged: (query) async {
                  List<String> suggestions = await controller.getPlaces(query);
                  if (suggestions.isNotEmpty) {
                    showLocationSuggestions(
                        suggestions,
                        context,
                        (title == 'Départ')
                            ? controller.startLocationController
                            : controller.endLocationController);
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'choose_your_address'.tr,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/course_map');
              },
              child: Text('Choisir sur la carte'),
            ),
          ],
        ),
      ],
    );
  }
}

class LocationPage extends StatelessWidget {
  final LocationPickerController controller =
      Get.put(LocationPickerController());
  final userInfos = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose_place'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LocationTextField(
              title: 'start'.tr,
              controller: controller,
            ),
            SizedBox(height: 20),
            LocationTextField(
              title: 'end'.tr,
              controller: controller,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.saveLocations();
                Map<String, dynamic> userData = controller.getStorage();
                String engin = userData['engin'];
                userInfos.write('departLieu',
                    controller.startLocationController.text.toString());
                userInfos.write('arriveeLieu',
                    controller.endLocationController.text.toString());
                if (engin == 'Voiture') {
                  Get.toNamed('/voiture');
                } else if (engin == 'Moto') {
                  Get.toNamed('/moto');
                } else if (engin == 'Tricycle') {
                  Get.toNamed('/tricycle');
                }
              },
              child: Text('choose_a_driver'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
