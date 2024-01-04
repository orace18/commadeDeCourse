import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/google_services.dart';
import 'package:otrip/math_services.dart';
import 'package:otrip/pages/engin_page/controllers/moto_drivers_controller.dart';

class TricycleDriversPage extends GetWidget<MotoDriversController> {
  TricycleDriversPage({required String enginType}) {
    Get.put(MotoDriversController(enginType: enginType));
  }

  GoogleServiceOtrip googleServiceOtrip = GoogleServiceOtrip();
  MathServices mathServices = MathServices();

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
              Map<String, dynamic>? positions = user['user']['positions'];
              double? latitude = positions?['latitude'];
              double? longitude = positions?['longitude'];
              Future<String?> lieux =
                  googleServiceOtrip.getPlaceName(latitude, longitude);
              //mathServices.calculateDistance(myLatitude, myLongitude, latitude!, longitude!);

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nom: ${user['user'] != null ? user['user']['name'] ?? 'N/A' : 'N/A'} ${user['user']['lastname'] ?? ''}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                          'Numéro de téléphone: ${user['user']['mobile_number']}'),
                      SizedBox(height: 8.0),
                      if (positions != null)
                        Text('Latitude: $latitude, Longitude: $longitude, Lieu: $lieux'),
                      //Text('Lieu: $lieux'),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
