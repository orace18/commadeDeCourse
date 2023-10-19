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

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = google_api_key;

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
            Get.snackbar('Hi', distance);
            Get.snackbar('The nearest is', nearest.markerId.value);
            _getPolyline();
            // setPolylines(_destination);
            print("ze");
          });
        }
      ),
    );
  }


  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(_initialPosition.latitude, _initialPosition.longitude),
        PointLatLng(_destination.latitude, _destination.longitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  // Future<List<PointLatLng>> _createPolylines(LatLng start, LatLng destination) async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   List<PointLatLng> results = [];
  //
  //   PolylineResult response = await polylinePoints.getRouteBetweenCoordinates(
  //     google_api_key,
  //     PointLatLng(start.latitude, start.longitude),
  //     PointLatLng(destination.latitude, destination.longitude),
  //   );
  //
  //   if (response.points.isNotEmpty) {
  //     response.points.forEach((PointLatLng point) {
  //       results.add(point);
  //     });
  //   }
  //
  //   return results;
  // }
  //
  // void setPolylines(LatLng destinationPosition) async {
  //   List<PointLatLng> result = await _createPolylines(LatLng(_initialPosition.latitude,_initialPosition.longitude), destinationPosition);
  //   if (result.isNotEmpty) {
  //     result.forEach((PointLatLng point) {
  //       Polyline polyline = Polyline(
  //         polylineId: PolylineId('poly'),
  //         color: Colors.blue,
  //         width: 3,
  //         points: <LatLng>[LatLng(point.latitude, point.longitude)],
  //       );
  //       _polylines.add(polyline);
  //     });
  //   }
  // }

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

