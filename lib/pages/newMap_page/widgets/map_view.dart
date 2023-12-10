import 'dart:async';
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

  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor srcIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor desIcon = BitmapDescriptor.defaultMarker;

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

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/icons/maps/bike.png"
    ).then((icon) => desIcon = icon);

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        "assets/icons/maps/taxi.png"
    ).then((icon) => srcIcon = icon);

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        "assets/icons/maps/client.png"
    ).then((icon) => currentLocationIcon = icon);
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
            icon: currentLocationIcon,
            position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
          ),
          Marker(
              markerId: MarkerId("src"),
              icon: srcIcon,
              position: src
          ),
          Marker(
              markerId: MarkerId("des"),
              icon: desIcon,
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
