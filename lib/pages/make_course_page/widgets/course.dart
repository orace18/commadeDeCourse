import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/providers/theme/theme.dart';

import '../controllers/course_controller.dart';

class LocationTextField extends StatelessWidget {
  final String title;
  final LocationPickerController controller;
  final Function(String) onChanged;

  LocationTextField({
    required this.title,
    required this.controller,
    required this.onChanged,
  });



  void showLocationSuggestions(List<String> suggestions, BuildContext context,
      TextEditingController textEditingController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(suggestions[index]),
                  onTap: () {
                    textEditingController.text = suggestions[index];
                    Navigator.of(context).pop();

                  },
                );
              },
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: onChanged,
                controller: (title == 'Départ')
                    ? controller.startLocationController
                    : controller.endLocationController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'choose_your_address'.tr,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      String query = (title == 'Départ')
                          ? controller.startLocationController.text
                          : controller.endLocationController.text;
                      List<String> suggestions = await controller.getPlaces(query);
                      if (_focusNode.hasFocus && suggestions.isNotEmpty) {
                        showLocationSuggestions(
                            suggestions,
                            context,
                            (title == 'Départ')
                                ? controller.startLocationController
                                : controller.endLocationController);
                        _focusNode.requestFocus();
                      }
                    },
                    child: const Icon(Icons.search),
                  ),
                ),
                focusNode: _focusNode,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class LocationPage extends StatelessWidget {
  final LocationPickerController controller = Get.put(LocationPickerController());
  final userInfos = GetStorage();

  final startLocation = ''.obs;
  final endLocation = ''.obs;



  LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isReady = RxBool(false);

    void checkReady() {
      isReady.value = startLocation.value.isNotEmpty && endLocation.value.isNotEmpty;
    }

    ever(startLocation, (_) => checkReady());
    ever(endLocation, (_) => checkReady());

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
              onChanged: (value) => startLocation.value = value,
            ),
            const SizedBox(height: 20),
            LocationTextField(
              title: 'end'.tr,
              controller: controller,
              onChanged: (value) => endLocation.value = value,
            ),
            const Spacer(),
            Obx(() => Visibility(
              visible: isReady.value,
              child: ElevatedButton(
                onPressed: () {
                  controller.saveLocations();
                  Map<String, dynamic> userData = controller.getStorage();
                  String engin = userData['engin'];
                  userInfos.write('departLieu',
                      controller.startLocationController.text.toString());
                  userInfos.write('arriveeLieu',
                      controller.endLocationController.text.toString());
                  controller.adrLocations();
                  if (engin == 'Voiture') {
                    Get.toNamed('/voiture');
                  } else if (engin == 'Moto') {
                    Get.toNamed('/moto');
                  } else if (engin == 'Tricycle') {
                    Get.toNamed('/tricycle');
                  }
                },
                style: ElevatedButton.styleFrom(
                  surfaceTintColor: Colors.white,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  elevation: 0,
                  backgroundColor: AppTheme.otripMaterial ,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                child: Text('choose_a_driver'.tr, style: const TextStyle(color: Colors.white)),
              ),
            )),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/course_map');
              },
              style: ElevatedButton.styleFrom(
                surfaceTintColor: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                elevation: 0,
                backgroundColor: AppTheme.otripMaterial,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              child: const Text('Choisir sur la carte', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
