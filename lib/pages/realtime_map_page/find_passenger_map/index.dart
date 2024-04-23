import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:otrip/constants.dart';

class FindDriverOnMap extends StatefulWidget {
  const FindDriverOnMap({Key? key}) : super(key: key);

  @override
  State<FindDriverOnMap> createState() => FindDriverOnMapState();
}

class FindDriverOnMapState extends State<FindDriverOnMap> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(6.3792038, 2.3499155);
  static const LatLng destinationLocation = LatLng(6.3634828, 2.3587669);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;
    });

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen(
          (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                zoom: 13.5,
                target: LatLng(newLoc.latitude!, newLoc.longitude!))));
        setState(() {});
      },
    );
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  void setCustomMakerIcon() {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets\illustrations\depart.png")
        .then((icon) {
      sourceIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets\illustrations\arrivee.png")
        .then((icon) {
      destinationIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets\illustrations\podition.png")
        .then((icon) {
      currentLocationIcon = icon;
    });
  }

  @override
  void initState() {
    //setCustomMakerIcon();
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('La map driver'),
      ),
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
              currentLocation!.latitude!, currentLocation!.longitude!),
          zoom: 13.5,
        ),
        polylines: {
          Polyline(
              polylineId: PolylineId('route'),
              points: polylineCoordinates,
              color: Colors.orange,
              width: 6)
        },
        markers: {
          Marker(
            markerId: MarkerId("currentLocation"),
            // icon: currentLocationIcon,
            position: LatLng(
                currentLocation!.latitude!, currentLocation!.longitude!),
          ),
          Marker(
            markerId: MarkerId("Source"),
            // icon: sourceIcon,
            position: sourceLocation,
          ),
          Marker(
            markerId: MarkerId("Destination"),
            // icon: destinationIcon,
            position: destinationLocation,
          ),
        },
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
      ),
    );
  }
}
