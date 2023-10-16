import 'package:flutter/material.dart';
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
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.7749, -122.4194);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
    );
  }

  Future<positions.Position> getCurrentLocation() async {
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

