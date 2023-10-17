import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/models/position.dart' as positions;

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController _mapController;

  late positions.Position _initialPosition;

  @override
  void initState() {
    getCurrentLocation().then((position) {
      setState(() {
        _initialPosition = position;
      });
    });
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      // Si vous avez la position initiale, l'utiliser comme CameraPosition initiale
      if (_initialPosition != null) {
        _mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(_initialPosition.latitude, _initialPosition.longitude),
              zoom: 14.0,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(0, 0),
        zoom: 14.0,
      ),
      markers: Set<Marker>.from([
        Marker(
          markerId: MarkerId('user_location'),
          position: LatLng(37.43296265331129, -122.08832357078792),
          icon: BitmapDescriptor.defaultMarker,
        ),
      ]),
    );
  }

  Future<positions.Position> getCurrentLocation() async {
    // bool serviceEnabled;
    // LocationPermission permission;
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //
    // if (!serviceEnabled) {
    //   Get.back();
    // }
    //
    // permission = await Geolocator.checkPermission();
    // print("permission : ${permission}");
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     Get.back();
    //   }
    // }
    //
    // if (permission == LocationPermission.deniedForever) {
    //   // Permissions are denied forever, handle appropriately.
    //   Get.back();
    // }

    positions.Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  double calculateDistance(positions.Position userPosition, double targetLatitude, double targetLongitude) {
    double distanceInMeters = Geolocator.distanceBetween(
      userPosition.latitude,
      userPosition.longitude,
      targetLatitude,
      targetLongitude,
    );
    return distanceInMeters;
  }

  double findClosestLocation(positions.Position userPosition, List<LatLng> locations) {
    double minDistance = double.infinity;

    for (LatLng location in locations) {
      double distance = calculateDistance(userPosition, location.latitude, location.longitude);
      if (distance < minDistance) {
        minDistance = distance;
      }
    }

    return minDistance;
  }


}

