import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:otrip/pages/legalmention_page/controllers/legalmention_controller.dart';

class SearchBar extends StatelessWidget {
  final LocationPickerController controller =
      Get.find<LocationPickerController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(Icons.search),
          SizedBox(width: 8.0),
          Expanded(
            child: FutureBuilder<List<String>>(
              future: controller.getPlaces(
                  'Agla'), // Vous pouvez également utiliser une chaîne vide ou un texte initial ici
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final places = snapshot.data ?? [];
                  return DropdownButton<String>(
                    items: places
                        .map((place) => DropdownMenuItem<String>(
                              value: place,
                              child: Text(place),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      // Do something with the selected place, if needed
                      controller.getPlaces(newValue!);
                    },
                    isExpanded: true,
                    hint: Text('Rechercher un quartier...'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LocationPickerView extends GetView<LocationPickerController> {
  LocationPickerView({Key? key}) : super(key: key);
  final LocationPickerController controller =
      Get.put(LocationPickerController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 400,
        width: double.infinity,
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: controller.defaultLatLng,
                zoom: 10.0,
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              left: 16,
              child: SearchBar(),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    value: controller.listPlace.isNotEmpty
                        ? controller.listPlace[0]
                        : null,
                    items: controller.listPlace.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      controller.startLocationController.text = newValue!;
                    },
                    decoration: InputDecoration(labelText: 'Départ'),
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: controller.listPlace.isNotEmpty
                        ? controller.listPlace[0]
                        : null,
                    items: controller.listPlace.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      controller.endLocationController.text = newValue!;
                    },
                    decoration: InputDecoration(labelText: 'Arrivée'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.chooseLocation,
                    child: Text('Choisir l\'emplacement'),
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
