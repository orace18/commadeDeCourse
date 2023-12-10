import 'dart:async';
import 'dart:ui' as ui;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../../constants.dart';

class MapView extends StatefulWidget {
  const MapView({super.key, required this.initialPositon});
  final LocationData initialPositon;

  @override
  State<MapView> createState() => _MapViewState();

}

class _MapViewState extends State<MapView> {
  bool loadingLocation = true;
  String googleAPiKey = google_api_key;

  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng src = LatLng(6.4413180, 2.3066649);
  static const LatLng des = LatLng(6.371736, 2.363729);

  Set<Marker> _markers = Set<Marker>();
  
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor userIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor taxiIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor clientIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor bikeIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation () async {
    Location location = Location();

    currentLocation = widget.initialPositon;
    // location.getLocation().then((location) {
    //   currentLocation = location;
    //   setState(() {
    //     loadingLocation = false;
    //   });
    // });

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen(
        (newLocation) {
          currentLocation = newLocation;
          
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(
                target: LatLng(newLocation.latitude!,newLocation.longitude!),
                zoom: 15.5
              )
            )
          );
        }
    );
  }

  void setCustomMarkerIcon () async {

    final Uint8List? bikeMarker= await getBytesFromAsset(
        path:"assets/icons/maps/bike.png", //paste the custom image path
        width: 60 // size of custom image as marker
    );

    final Uint8List? taxiMarker= await getBytesFromAsset(
        path:"assets/icons/maps/taxi.png", //paste the custom image path
        width: 60 // size of custom image as marker
    );

    final Uint8List? clientMarker= await getBytesFromAsset(
        path:"assets/icons/maps/client.png", //paste the custom image path
        width: 60 // size of custom image as marker
    );

    final Uint8List? userMarker= await getBytesFromAsset(
        path:"assets/icons/maps/user.png", //paste the custom image path
        width: 60 // size of custom image as marker
    );

    userIcon = BitmapDescriptor.fromBytes(userMarker!);
    clientIcon = BitmapDescriptor.fromBytes(clientMarker!);
    taxiIcon = BitmapDescriptor.fromBytes(taxiMarker!);
    bikeIcon = BitmapDescriptor.fromBytes(bikeMarker!);
  }

  void getPolyPoints(LatLng destination) async {
    PolylinePoints polylinePoints = PolylinePoints();

    if (polylineCoordinates.isNotEmpty){
      polylineCoordinates.clear();
    }

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng pointLatLng) {
        polylineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
        }
      );
      setState(() {

      });
    }
  }

  Future<Uint8List?> getBytesFromAsset({required String path,required int width})async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
        format: ui.ImageByteFormat.png))
        ?.buffer.asUint8List();
  }

  @override
  void initState() {
    getCurrentLocation();
    setCustomMarkerIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GoogleMap(
        onMapCreated: (mapController){
          _controller.complete(mapController);
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            zoom: 15.5
        ),
        markers: {
          Marker(
              markerId: const MarkerId(''),
              icon: userIcon,
              position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
          ),
        }.union(_markers),
        polylines: {
          Polyline(
              polylineId: PolylineId("road"),
              points: polylineCoordinates,
              color: Colors.green,
              width: 5
          )
        },
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _markers.add(
            Marker(
                markerId: MarkerId("src"),
                icon: bikeIcon,
                position: src,
                onTap: (){
                  getPolyPoints(LatLng(src.latitude, src.longitude));
                },
                infoWindow: InfoWindow(
                    title: "Chez moi",
                    snippet: "3 stars"
                )
            ),
          );
          setState(() {

          });
        },
        child: Icon(Icons.search),
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Marker findClosestLocation(List<Marker> locations) {
    late Marker closest;
    LocationData? userPosition = currentLocation;
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

  double calculateDistance(LocationData? userPosition, double targetLatitude, double targetLongitude) {
    double distanceInMeters = Geolocator.distanceBetween(
      userPosition!.latitude!,
      userPosition.longitude!,
      targetLatitude,
      targetLongitude,
    );
    return distanceInMeters;
  }

  void sendRequestToDriver(){

  }

  // Code pour accepter la demande de course
  void answerUserRequest(){

  }
  // suivi dd l'itinéraire vers le client
  void roadToClient(){

  }

  // Demarrer la course
  void startTrip(){

  }
  // Calcul du montant de commission
  void tripCash(){

  }
}
