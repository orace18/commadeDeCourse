import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:otrip/math_services.dart';
import 'package:otrip/pages/engin_page/controllers/moto_drivers_controller.dart';

class VoitureDriversPage extends GetWidget<MotoDriversController> {
  late double maLatitude;
  late double maLongitude;

  VoitureDriversPage({required String enginType}) {
    Get.put(MotoDriversController(enginType: enginType));
    _getCurrentLocation();
  }

  // Méthode pour obtenir la position actuelle
  Future<void> _getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData locationData = await location.getLocation();
    maLatitude = locationData.latitude!;
    maLongitude = locationData.longitude!;
  }

  @override
  void onInit() {
    controller.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Conducteur de ${controller.enginType}'),
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Naviguer en arrière lorsque l'icône est cliquée
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.driverList.isEmpty) {
          return Center(child: Text('Aucun utilisateur trouvé.'));
        } else {
          return ListView.builder(
            itemCount: controller.driverList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> user = controller.driverList[index];

              // Extraire les valeurs de positions
              Map<String, dynamic>? positions = user['users']['positions'];
              double? latitude = positions?['latitude'];
              double? longitude = positions?['longitude'];
              double? distance = MathServices().calculateDistance(
                maLatitude,
                maLongitude,
                latitude!,
                longitude!,
              );

              return FutureBuilder<String?>(
                future: controller.getPlaceName(latitude, longitude),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur: ${snapshot.error}');
                  } else {
                    String? lieu = snapshot.data;

                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nom: ${user['users'] != null ? user['users']['name'] ?? 'N/A' : 'N/A'} ${user['users']['lastname'] ?? ''}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Numéro de téléphone: ${user['users']['mobile_number']}',
                            ),
                            SizedBox(height: 8.0),
                            if (positions != null)
                              Text(
                                'Lieu: ${lieu.toString()} - A $distance km de vous',
                              ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            },
          );
        }
      }),
    );
  }
}
