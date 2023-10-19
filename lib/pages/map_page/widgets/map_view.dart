import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/models/position.dart' as positions;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../../../constants.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController _mapController;

  late positions.Position _initialPosition;
  late LatLng _destination;

  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();

  String googleAPiKey = google_api_key;

  @override
  void initState() {
    // getCurrentLocation().then((position) {
    //   print(position);
    //   setState(() {
    //     _initialPosition = position;
    //   });
    // });
    _addMarker(LatLng(6.375373, 2.357766), "place1");
    _addMarker(LatLng(6.372538, 2.363626), "place2");
    _addMarker(LatLng(6.371736, 2.363729), "place3");
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    setState(() {
      _getLocation();
    });
  }

  _getLocation() async {
    _initialPosition = await getCurrentLocation();
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_initialPosition.latitude, _initialPosition.longitude),
          zoom: 16.0,
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('user_location'),
        position: LatLng(_initialPosition.latitude, _initialPosition.longitude),
        infoWindow: InfoWindow(title: 'Position actuelle'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(0, 0),
        zoom: 14.0,
      ),
      markers: Set<Marker>.of(_markers),
      polylines: _polylines,
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
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    positions.Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  void _addMarker(LatLng position, String markerId) {
    var title = "place";
    _markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: position,
        infoWindow: InfoWindow(title: title),
        onTap: (){
          setState(() {
            var nearest = findClosestLocation(_markers.toList());
            var distance = calculateDistance(_initialPosition, position.latitude, position.longitude).toString();
            _destination = position;
            // Get.snackbar('Hi', distance);
            // Get.snackbar('The nearest is', nearest.markerId.value);

            _getPolyline(_destination);
            print("ze");
          });
        }
      ),
    );
  }

  Future<void> _getPolyline(LatLng destination) async {
    // Obtenez les coordonnées du chemin entre _currentPosition et la destination
    List<LatLng> coordinates = await getRouteCoordinates(destination);

    // Affichez le chemin sur la carte avec une Polyline
    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId('route'),
        color: Colors.red,
        width: 3,
        points: coordinates,
      ));
    });
  }

  Future<List<LatLng>> getRouteCoordinates(LatLng destination) async {
    final apiKey = googleAPiKey; // Remplacez par votre propre clé API Google Directions

    final String origin = '${_initialPosition.latitude},${_initialPosition.longitude}';
    final String destinationStr = '${destination.latitude},${destination.longitude}';
    final String apiUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destinationStr&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final List<LatLng> coordinates = [];
        final List<dynamic> steps = data['routes'][0]['legs'][0]['steps'];
        steps.forEach((step) {
          final String encodedPolyline = step['polyline']['points'];
          coordinates.addAll(_decodePoly(encodedPolyline));
        });
        return coordinates;
      } else {
        throw Exception('Failed to load route');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<LatLng> _decodePoly(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      double latitude = lat / 1e5;
      double longitude = lng / 1e5;
      poly.add(LatLng(latitude, longitude));
    }
    return poly;
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

  Marker findClosestLocation( List<Marker> locations) {
    late Marker closest;
    positions.Position userPosition = _initialPosition;
    double minDistance = double.infinity;

    for (Marker location in locations) {
      double distance = calculateDistance(userPosition, location.position.latitude, location.position.longitude);
      if (distance < minDistance && location.markerId.value != "user_location") {
        minDistance = distance;
        closest = location;
      }
    }
    return closest;
  }


}

