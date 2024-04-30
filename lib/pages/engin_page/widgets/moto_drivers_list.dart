import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:otrip/math_services.dart';
import 'package:otrip/pages/engin_page/controllers/moto_drivers_controller.dart';
import 'package:otrip/pages/make_course_page/controllers/course_controller.dart';
import '../../../constants.dart';
import '../../../providers/theme/theme.dart';
import '../../realtime_map_page/find_driver_map/index.dart';

class MotoDriversPage extends GetWidget<MotoDriversController> {
  late double maLatitude = 6.3792038;
  late double maLongitude = 2.3499155;

  MotoDriversPage({required String enginType}) {
    Get.put(MotoDriversController(enginType: enginType));
    _getCurrentLocation();
  }
  LocationPickerController pickerController = LocationPickerController();

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
    _getCurrentLocation();
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
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator(color: Colors.deepOrange));
              } else if (controller.driverList.isEmpty) {
                return Center(child: Text('Aucun conducteur trouvé.'));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.driverList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> user = controller.driverList[index];

                    // Extraire les valeurs de positions
                    Map<String, dynamic>? positions = user['users']['positions'];
                    double? latitude = positions?['latitude'];
                    double? longitude = positions?['longitude'];
                    String distance = MathServices().calculateDistance(
                      maLatitude,
                      maLongitude,
                      latitude!,
                      longitude!,
                    );

                    return FutureBuilder<String?>(
                      future: controller.getPlaceName(latitude, longitude),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(color:Colors.deepOrange);
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erreur: ${snapshot.error}'));
                        } else {
                          String? lieu = snapshot.data;
                          return GestureDetector(
                            onTap: () {
                              int id_conducteur = user['users']['id'];
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text('valid'.tr),
                                    content: Text('make_course_to'.tr +
                                        ' ' +
                                        '${user['users']['name']} ${user['users']['lastname']}'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Fermer la boîte de dialogue
                                        },
                                        style: ElevatedButton.styleFrom(
                                            surfaceTintColor: Colors.white,
                                            textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                            elevation: 0,
                                            backgroundColor: AppTheme.otripMaterial,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0))
                                        ),
                                        child: Text('close'.tr, style: TextStyle(color: Colors.white)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          String engin = GetStorage().read('engin');
                                          print('L\'engin est: $engin');
                                          int id_passager = GetStorage().read('id');
                                          print("L'id du passager: $id_passager");
                                          String depart =
                                          GetStorage().read('departLieu');
                                          print("L'addresse de départ: $depart");
                                          String arrivee =
                                          GetStorage().read('arriveeLieu');
                                          print("L'addresse d'arrivée: $arrivee");
                                          bool sucess = await pickerController.makeCourse(
                                              engin,
                                              depart,
                                              arrivee,
                                              id_passager.toString(),
                                              id_conducteur.toString());

                                          if (sucess) {
                                            returnSuccess('course_done'.tr);
                                          } else {
                                            returnSuccess('course_failed'.tr);
                                          }
                                          Get.back();
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            surfaceTintColor: Colors.white,
                                            textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                            elevation: 0,
                                            backgroundColor: AppTheme.otripMaterial,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0))
                                        ),
                                        child: Text('valid'.tr, style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Card(
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
                                        'Lieu: ${lieu.toString() ?? 'N/A'} - à $distance km de vous',
                                      ),
                                  ],
                                ),
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
            SizedBox(height: 20), // Espacement entre la liste et le bouton
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(FindDriverOnMap());
                },
                style: ElevatedButton.styleFrom(
                    surfaceTintColor: Colors.white,
                    textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    elevation: 0,
                    backgroundColor: AppTheme.otripMaterial,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))
                ),
                child: Text('Choisir un conducteur sur la map',style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
