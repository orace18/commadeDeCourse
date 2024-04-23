import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants.dart';
import '../../../providers/theme/theme.dart';

class StartCoursePage extends StatefulWidget {
  String depart;
  String destination;
  StartCoursePage({required this.depart, required this.destination});
  @override
  _StartCoursePageState createState() => _StartCoursePageState();
}

class _StartCoursePageState extends State<StartCoursePage> {
  LatLng? _currentLocation;
  LatLng? _departLocation;
  LatLng? _destinationLocation;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _getDepartureDestinationCoordinates();

    // Actualiser la carte toutes les 15 secondes
    Timer.periodic(Duration(seconds: 15), (timer) {
      _getCurrentLocation();
      _getDepartureDestinationCoordinates();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course en cours'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentLocation ?? LatLng(0, 0),
                zoom: 14.0,
              ),
              markers: _markers,
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                  surfaceTintColor: Colors.white,
                  textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  elevation: 0,
                  backgroundColor: AppTheme.otripMaterial,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))
              ),
              child: Text('Terminer la course', style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _addMarker(_currentLocation!, 'Current Location');
      _moveCamera(_currentLocation!);
    });
  }

  Future<void> _getDepartureDestinationCoordinates() async {
    // Obtenir les coordonnées géographiques du lieu de départ
    String departurePlace = widget.depart;
    print('Le depart est: $departurePlace');

    String departureUrl = 'https://maps.googleapis.com/maps/api/geocode/json?address=$departurePlace&key=$google_api_key';
    var departureResponse = await http.get(Uri.parse(departureUrl));
    var departureData = json.decode(departureResponse.body);
    if (departureData['status'] == 'OK') {
      var departureResults = departureData['results'];
      if (departureResults.isNotEmpty) {
        var departureLocation = departureResults[0]['geometry']['location'];
        double departureLat = departureLocation['lat'];
        double departureLng = departureLocation['lng'];
        _departLocation = LatLng(departureLat, departureLng);
        print('Les coordonnées: $_departLocation');
        _addMarker(_departLocation!, 'Departure');
        _getRoute();
      }
    }

    // Obtenir les coordonnées géographiques du lieu de destination
    String destinationPlace = widget.destination;
    print('La destination est: $destinationPlace');
    String destinationUrl = 'https://maps.googleapis.com/maps/api/geocode/json?address=$destinationPlace&key=$google_api_key';
    var destinationResponse = await http.get(Uri.parse(destinationUrl));
    var destinationData = json.decode(destinationResponse.body);
    if (destinationData['status'] == 'OK') {
      var destinationResults = destinationData['results'];
      if (destinationResults.isNotEmpty) {
        var destinationLocation = destinationResults[0]['geometry']['location'];
        double destinationLat = destinationLocation['lat'];
        double destinationLng = destinationLocation['lng'];
        _destinationLocation = LatLng(destinationLat, destinationLng);
        print('Les coordonnées: $_destinationLocation');
        _addMarker(_destinationLocation!, 'Destination');
        _getRoute();
      }
    }
  }

  void _addMarker(LatLng position, String markerId) {
    _markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: position,
        infoWindow: InfoWindow(title: markerId),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );
  }

  Future<void> _moveCamera(LatLng target) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(target));
  }

  Future<void> _getRoute() async {
    if (_departLocation != null && _destinationLocation != null && _currentLocation != null) {
      // Route du départ à la position actuelle
      String urlToCurrentLocation =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${_departLocation!.latitude},${_departLocation!.longitude}&destination=${_currentLocation!.latitude},${_currentLocation!.longitude}&key=$google_api_key';
      var responseToCurrentLocation = await http.get(Uri.parse(urlToCurrentLocation));
      var dataToCurrentLocation = json.decode(responseToCurrentLocation.body);
      if (dataToCurrentLocation['status'] == 'OK') {
        var routes = dataToCurrentLocation['routes'];
        if (routes.isNotEmpty) {
          var points = routes[0]['overview_polyline']['points'];
          List<LatLng> decodedPoints = _decodePoly(points);
          setState(() {
            _polylines.add(Polyline(
              polylineId: PolylineId('route_to_current_location'),
              color: Colors.grey, // Couleur pour le chemin vers la position actuelle
              width: 5,
              points: decodedPoints,
            ));
          });
        }
      }

      // Route de la destination à la position actuelle
      String urlToDestination =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${_destinationLocation!.latitude},${_destinationLocation!.longitude}&destination=${_currentLocation!.latitude},${_currentLocation!.longitude}&key=$google_api_key';
      var responseToDestination = await http.get(Uri.parse(urlToDestination));
      var dataToDestination = json.decode(responseToDestination.body);
      if (dataToDestination['status'] == 'OK') {
        var routes = dataToDestination['routes'];
        if (routes.isNotEmpty) {
          var points = routes[0]['overview_polyline']['points'];
          List<LatLng> decodedPoints = _decodePoly(points);
          setState(() {
            _polylines.add(Polyline(
              polylineId: PolylineId('route_to_destination'),
              color: Colors.indigo, // Couleur pour le chemin vers la destination
              width: 5,
              points: decodedPoints,
            ));
          });
        }
      }
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
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      double latDouble = lat / 1E5;
      double lngDouble = lng / 1E5;
      LatLng position = LatLng(latDouble, lngDouble);
      poly.add(position);
    }
    return poly;
  }
}
