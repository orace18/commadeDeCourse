import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:otrip/pages/realtime_map_page/find_driver_map/controllers/find_driver_controller.dart';
import 'package:otrip/providers/theme/theme.dart';
import '../../../api/api_constants.dart';
import '../../../constants.dart';
import '../../make_course_page/controllers/course_controller.dart';


class FindDriverOnMap extends StatefulWidget {
  const FindDriverOnMap({Key? key}) : super(key: key);

  @override
  State<FindDriverOnMap> createState() => FindDriverOnMapState();
}

class FindDriverOnMapState extends State<FindDriverOnMap> {
  FindDriverOnMapController controller = FindDriverOnMapController();
  final Completer<GoogleMapController> _controller = Completer();
  LocationData? currentLocation;
  List<Marker> _markers = [];
  late Timer _timer;
  LocationPickerController pickerController = LocationPickerController();



  String engin = GetStorage().read('engin').toString();

  // Méthode pour obtenir la position actuelle de l'utilisateur
  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();
    return await location.getLocation();
  }

  Future<List<Map<String, dynamic>>> getUsersByEngin(String engin) async {
    try {
      final response = await http.get(Uri.parse('$driverByEngin/$engin'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is List<dynamic> && responseData.isNotEmpty) {
          List<Map<String, dynamic>> driverList =
          List<Map<String, dynamic>>.from(responseData);
          print('Les drivers: $driverList');
          return driverList;
        } else {
          throw Exception('Invalid response format for users by engin type.');
        }
      } else {
        throw Exception('Error loading user list: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }


  // Méthode pour mettre à jour les marqueurs des conducteurs
  Future<void> _updateMarkers() async {
    List<Map<String, dynamic>> users = await getUsersByEngin('$engin');

    setState(() {
      _markers.clear();
      // Ajouter un marqueur pour la position actuelle de l'utilisateur
      if (currentLocation != null) {
        _markers.add(
          Marker(
            markerId: MarkerId('currentLocation'),
            position: LatLng(currentLocation!.latitude!,
                currentLocation!.longitude!),
            infoWindow: InfoWindow(title: 'Votre position actuelle'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
          ),
        );
      }
      // Ajouter les marqueurs des conducteurs
      for (var user in users) {
        if (user['users']['positions'] != null) {
          double? latitude = user['users']['positions']['latitude'];
          double? longitude = user['users']['positions']['longitude'];
          String username = user['users']['username'];
          String nom = user['users']['name'];
          String prenom = user['users']['lastname'];
          String tel = user['users']['mobile_number'];
          int id_conducteur = user['users']['id'];

          if (latitude != null && longitude != null) {
            print('Adding marker for $username at ($latitude, $longitude)');
            _markers.add(
              Marker(
                  markerId: MarkerId(username),
                  position: LatLng(latitude, longitude),
                  infoWindow: InfoWindow(
                    title: username,
                    snippet: 'Position: $latitude, $longitude',
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueViolet,
                  ),
                  onTap: ()async {
                    String place = await controller.getPlaceName(latitude, longitude);

                    _showDriverInfoBottomSheet(context, username, prenom, nom, tel, id_conducteur, place);
                  }
              ),
            );
          }
        }
      }
    });
  }

  void _showDriverInfoBottomSheet(BuildContext context,  String username, String prenom, String nom, String tel, int id_conducteur, String place) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Informations du conducteur',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildInfoRow(Icons.person, 'Nom ', ' $nom'),
              _buildInfoRow(Icons.person, 'Prénom ', ' $prenom'),
              _buildInfoRow(Icons.phone, 'Téléphone', tel),
              _buildInfoRow(Icons.place, 'A', place),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async{
                  String engin = GetStorage().read('engin');
                  print('L\'engin est: $engin');
                  int id_passager = GetStorage().read('id');
                  print("L'id du passager: $id_passager");
                  String depart = GetStorage().read('departLieu');
                  print("L'addresse de départ: $depart");
                  String arrivee = GetStorage().read('arriveeLieu');
                  print("L'addresse d'arrivée: $arrivee");
                  bool sucess = await pickerController.makeCourse(
                    engin,
                    depart,
                    arrivee,
                    id_passager.toString(),
                    id_conducteur.toString(),
                  );


                  if (sucess) {
                    returnSuccess('course_done'.tr);
                  } else {
                    returnSuccess('course_failed'.tr);
                  }

                },
                style: ElevatedButton.styleFrom(
                    surfaceTintColor: Colors.white,
                    textStyle: TextStyle(fontWeight: FontWeight.bold,),
                    elevation: 0,
                    backgroundColor: AppTheme.otripMaterial,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))
                ),
                child: Text('Commander la course', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.otripMaterial),
        SizedBox(width: 10),
        Text(
          '$label : ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value),
      ],
    );
  }


  @override
  void initState() {
    super.initState();
    getCurrentLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
      _updateMarkers(); // Mettre à jour les marqueurs après avoir obtenu la position actuelle
    });

    // Actualiser les marqueurs toutes les 30 secondes
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      _updateMarkers();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel(); // Arrêter le timer lors de la suppression du widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('La map driver'),
      ),
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(currentLocation!.latitude!,
              currentLocation!.longitude!),
          zoom: 18.5,
        ),
        markers: Set<Marker>.from(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
