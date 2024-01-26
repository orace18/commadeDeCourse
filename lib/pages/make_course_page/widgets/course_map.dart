/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:math' show asin, atan2, cos, max, min, pi, sin, sqrt;
import 'package:otrip/constants.dart';
import 'package:otrip/google_services.dart';

class CourseMapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<CourseMapPage> {
  GoogleServiceOtrip googleServiceController = GoogleServiceOtrip();
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];

  LatLng? departureLocation;
  LatLng? destinationLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('choose_your_address'.tr),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(6.369092, 2.444803), // Cotonou par défaut
                zoom: 18.0,
              ),
              onTap: _onMapTapped,
              markers: markers,
              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  color: Colors.orange,
                  points: polylineCoordinates,
                ),
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final enginData = GetStorage();
              String engin = enginData.read('engin');
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
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void namePlaceToStorage(double latitudeDep, double longitudeDep,
      double latitudeFin, double longitudeFin) async {
    String? depart =
        await googleServiceController.getPlaceName(latitudeDep, longitudeDep);
    String? arrivee =
        await googleServiceController.getPlaceName(latitudeFin, longitudeFin);

    GetStorage().write('deparLieu', depart);
    GetStorage().write('arriveeLieu', arrivee);
  }

  void _onMapTapped(LatLng location) async {
    setState(() {
      // Supprimer les anciens marqueurs et la route
      markers.clear();
      polylineCoordinates.clear();

      // Ajouter un nouveau marqueur pour l'emplacement de départ
      if (departureLocation == null) {
        departureLocation = location;
        markers.add(
          Marker(
            markerId: MarkerId("departure"),
            position: departureLocation!,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(title: "Départ"),
          ),
        );
      }
      // Ajouter un nouveau marqueur pour l'emplacement d'arrivée
      else if (destinationLocation == null) {
        destinationLocation = location;
        markers.add(
          Marker(
            markerId: MarkerId("destination"),
            position: destinationLocation!,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(title: "Arrivée"),
          ),
        );

        // Calculer la route entre le départ et l'arrivée
        _getPolyline();

        // Calculer et afficher la distance entre les deux points
        double distance = _calculateDistance(
          departureLocation!.latitude,
          departureLocation!.longitude,
          destinationLocation!.latitude,
          destinationLocation!.longitude,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Distance : ${distance.toStringAsFixed(2)} km'),
          ),
        );

        // Ajuster la caméra pour inclure les deux marqueurs
        mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(
                min(departureLocation!.latitude, destinationLocation!.latitude),
                min(departureLocation!.longitude,
                    destinationLocation!.longitude),
              ),
              northeast: LatLng(
                max(departureLocation!.latitude, destinationLocation!.latitude),
                max(departureLocation!.longitude,
                    destinationLocation!.longitude),
              ),
            ),
            50.0, // Padding de 50.0 (peut être ajusté)
          ),
        );

        // Enregistrer les noms des lieux dans GetStorage
        namePlaceToStorage(
            departureLocation!.latitude,
            departureLocation!.longitude,
            destinationLocation!.latitude,
            destinationLocation!.longitude);
      }
      // Si les deux emplacements sont déjà sélectionnés, réinitialiser tout
      else {
        departureLocation = null;
        destinationLocation = null;
      }
    });
  }

  Future<void> _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(departureLocation!.latitude, departureLocation!.longitude),
      PointLatLng(
          destinationLocation!.latitude, destinationLocation!.longitude),
    );

    if (result.points.isNotEmpty) {
      setState(() {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
    }
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // Rayon de la Terre en kilomètres
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _toRadians(double degree) {
    return degree * (pi / 180);
  }
}
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:math' show asin, atan2, cos, max, min, pi, sin, sqrt;
import '../../../constants.dart';
import '../../../google_services.dart';

class CourseMapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<CourseMapPage> {
  GoogleServiceOtrip googleServiceController = GoogleServiceOtrip();
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];

  LatLng? departureLocation;
  LatLng? destinationLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('choose_your_address'.tr),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(6.369092, 2.444803), // Cotonou par défaut
                zoom: 18.0,
              ),
              onTap: _onMapTapped,
              markers: markers,
              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  color: Colors.orange,
                  points: polylineCoordinates,
                ),
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final enginData = GetStorage();
              String engin = enginData.read('engin');
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
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void namePlaceToStorage(double latitudeDep, double longitudeDep,
      double latitudeFin, double longitudeFin) async {
    String? depart =
        await googleServiceController.getPlaceName(latitudeDep, longitudeDep);
    String? arrivee =
        await googleServiceController.getPlaceName(latitudeFin, longitudeFin);

    GetStorage().write('deparLieu', depart);
    GetStorage().write('arriveeLieu', arrivee);
  }

  void _onMapTapped(LatLng location) async {
    setState(() {
      // Supprimer les anciens marqueurs et la route
      markers.clear();
      polylineCoordinates.clear();

      // Ajouter un nouveau marqueur pour l'emplacement de départ
      if (departureLocation == null) {
        departureLocation = location;
        markers.add(
          Marker(
            markerId: MarkerId("departure"),
            position: departureLocation!,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(title: "Départ"),
          ),
        );
      }
      // Ajouter un nouveau marqueur pour l'emplacement d'arrivée
      else if (destinationLocation == null) {
        destinationLocation = location;
        markers.add(
          Marker(
            markerId: MarkerId("destination"),
            position: destinationLocation!,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(title: "Arrivée"),
          ),
        );

        // Calculer la route entre le départ et l'arrivée
        _getPolyline();

        // Calculer et afficher la distance entre les deux points
        double distance = _calculateDistance(
          departureLocation!.latitude,
          departureLocation!.longitude,
          destinationLocation!.latitude,
          destinationLocation!.longitude,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Distance : ${distance.toStringAsFixed(2)} km'),
          ),
        );

        // Ajuster la caméra pour inclure les deux marqueurs
        mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(
                min(departureLocation!.latitude, destinationLocation!.latitude),
                min(departureLocation!.longitude,
                    destinationLocation!.longitude),
              ),
              northeast: LatLng(
                max(departureLocation!.latitude, destinationLocation!.latitude),
                max(departureLocation!.longitude,
                    destinationLocation!.longitude),
              ),
            ),
            50.0, // Padding de 50.0 (peut être ajusté)
          ),
        );

        // Enregistrer les noms des lieux dans GetStorage
        namePlaceToStorage(
            departureLocation!.latitude,
            departureLocation!.longitude,
            destinationLocation!.latitude,
            destinationLocation!.longitude);
      }
      // Si les deux emplacements sont déjà sélectionnés, réinitialiser tout
      else {
        departureLocation = null;
        destinationLocation = null;
      }
    });
  }

  Future<void> _getPolyline() async {

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(departureLocation!.latitude, departureLocation!.longitude),
      PointLatLng(
          destinationLocation!.latitude, destinationLocation!.longitude),
          travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      setState(() {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
    }
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // Rayon de la Terre en kilomètres
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _toRadians(double degree) {
    return degree * (pi / 180);
  }
}
