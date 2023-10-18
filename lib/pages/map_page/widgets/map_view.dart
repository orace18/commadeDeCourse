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

  @override
  void initState() {
    // getCurrentLocation().then((position) {
    //   print(position);
    //   setState(() {
    //     _initialPosition = position;
    //   });
    // });
    _markers.add(
      Marker(
        markerId: MarkerId('user_location'),
        position: LatLng(6.371366, 2.3629711),
        infoWindow: InfoWindow(title: 'Position actuelle'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );
    _addMarker(LatLng(6.437155, 2.312605), "12-12");
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() async {
      _initialPosition = await getCurrentLocation();
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_initialPosition.latitude, _initialPosition.longitude),
            zoom: 16.0,
          ),
        ),
      );
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
    _markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: position,
        infoWindow: InfoWindow(title: markerId),
        onTap: (){
          setState(() {
            _destination = position;
            _getPolyline();
            print("ze");
          });
        }
      ),
    );
  }

  void _getPolyline() async {
    List<LatLng> coordinates = await getRouteCoordinates(
        LatLng(_initialPosition.latitude, _initialPosition.longitude),
        _destination);

    setState(() {
      _polylines.clear();
      _polylines.add(Polyline(
        polylineId: PolylineId('route'),
        color: Colors.orange,
        points: coordinates,
        width: 10,
      ));
    });
  }

  // Future<List<LatLng>> getRouteCoordinates(double startLat, double startLng, double endLat, double endLng) async {
  //   final apiKey = google_api_key;
  //   final apiUrl =
  //       'https://maps.googleapis.com/maps/api/directions/json?origin=$startLat,$startLng&destination=$endLat,$endLng&key=$apiKey';
  //
  //   final response = await http.get(Uri.parse(apiUrl));
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = json.decode(response.body);
  //     final List<LatLng> coordinates = [];
  //     if (data['status'] == 'OK') {
  //       final routes = data['routes'][0]['overview_polyline']['points'];
  //       coordinates.addAll(_decodePoly(routes));
  //     }
  //     return coordinates;
  //   } else {
  //     throw Exception('Failed to load route');
  //   }
  // }

  Future<List<LatLng>> getRouteCoordinates(LatLng start, LatLng destination) async {
    final apiKey = 'google_api_key'; // Remplacez par votre propre clé API Google Directions

    final String origin = '${start.latitude},${start.longitude}';
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

  // List<LatLng> _decodePoly(String poly) {
  //   final List<LatLng> decoded = [];
  //   int index = 0;
  //   int len = poly.length;
  //   int lat = 0, lng = 0;
  //
  //   while (index < len) {
  //     int shift = 0, result = 0;
  //
  //     // Décode la latitude
  //     while (true) {
  //       int byte = poly.codeUnitAt(index++) - 63;
  //       result |= (byte & 0x1F) << shift;
  //       shift += 5;
  //       if (byte < 0x20) break;
  //     }
  //
  //     // Décoder la latitude si c'est négatif
  //     lat += (result & 1) == 1 ? ~(result >> 1) : (result >> 1);
  //
  //     shift = 0;
  //     result = 0;
  //
  //     // Décode la longitude
  //     while (true) {
  //       int byte = poly.codeUnitAt(index++) - 63;
  //       result |= (byte & 0x1F) << shift;
  //       shift += 5;
  //       if (byte < 0x20) break;
  //     }
  //
  //     // Décoder la longitude si c'est négatif
  //     lng += (result & 1) == 1 ? ~(result >> 1) : (result >> 1);
  //
  //     decoded.add(LatLng(lat / 1E5, lng / 1E5));
  //   }
  //
  //   return decoded;
  // }

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

}

