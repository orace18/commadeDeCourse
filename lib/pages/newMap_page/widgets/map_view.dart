import 'dart:async';
import 'dart:ui' as ui;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../../constants.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();

}

class _MapViewState extends State<MapView> {

  String googleAPiKey = google_api_key;

  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng src = LatLng(6.472538, 2.363626);
  static const LatLng des = LatLng(6.371736, 2.363729);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor userIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor taxiIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor clientIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor bikeIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation () async {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;
    });

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen(
        (newLocation) {
          currentLocation = newLocation;
          
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(
                target: LatLng(newLocation.latitude!,newLocation.longitude!),
                zoom: 14.5
              )
            )
          );

          setState(() {

          });
        }
    );
  }

  void setCustomMarkerIcon () async {

    final Uint8List? bikeMarker= await getBytesFromAsset(
        path:"assets/icons/maps/bike.png", //paste the custom image path
        width: 50 // size of custom image as marker
    );

    final Uint8List? taxiMarker= await getBytesFromAsset(
        path:"assets/icons/maps/taxi.png", //paste the custom image path
        width: 50 // size of custom image as marker
    );

    final Uint8List? clientMarker= await getBytesFromAsset(
        path:"assets/icons/maps/client.png", //paste the custom image path
        width: 50 // size of custom image as marker
    );

    final Uint8List? userMarker= await getBytesFromAsset(
        path:"assets/icons/maps/user.png", //paste the custom image path
        width: 50 // size of custom image as marker
    );

    userIcon = BitmapDescriptor.fromBytes(userMarker!);
    clientIcon = BitmapDescriptor.fromBytes(clientMarker!);
    taxiIcon = BitmapDescriptor.fromBytes(taxiMarker!);
    bikeIcon = BitmapDescriptor.fromBytes(bikeMarker!);
    // BitmapDescriptor.fromAssetImage(
    //   ImageConfiguration.empty,
    //   "assets/icons/maps/bike.png"
    // ).then((icon) => desIcon = icon);
    //
    // BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration.empty,
    //     "assets/icons/maps/taxi.png"
    // ).then((icon) => srcIcon = icon);
    //
    // BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration.empty,
    //     "assets/icons/maps/client.png"
    // ).then((icon) => currentLocationIcon = icon);
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(src.latitude, src.longitude),
      PointLatLng(des.latitude, des.longitude),
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
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),

      body: currentLocation == null ?
      const Center(
        child: Text('...')
      ) :
      GoogleMap(
        onMapCreated: (mapController){
          _controller.complete(mapController);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          zoom: 14.5
        ),
        markers: {
          Marker(
            markerId: const MarkerId("current"),
            icon: userIcon,
            position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
          ),
          Marker(
              markerId: MarkerId("src"),
              icon: bikeIcon,
              position: src
          ),
          Marker(
              markerId: MarkerId("des"),
              icon: bikeIcon,
              position: des
          ),
        },
        polylines: {
          Polyline(
            polylineId: PolylineId("road"),
            points: polylineCoordinates,
            color: Colors.green,
            width: 5
          )
        },
      ),
    );
  }
}
