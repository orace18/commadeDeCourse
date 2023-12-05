import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class MapSample extends StatefulWidget {
  @override
  State createState() => MapSampleState();
}

// ...
class MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;
  late LocationData currentLocation;

  // Liste fictive de positions de Zems
  final List<LatLng> zemPositions = [
    LatLng(37.7749, -122.4194),
    LatLng(37.7899, -122.4104),
    // ... Ajoutez d'autres positions de Zems
  ];

  // ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zems à proximité'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            currentLocation.latitude ?? 0.0,
            currentLocation.longitude ?? 0.0,
          ),
          zoom: 15.0,
        ),
        markers: zemPositions
            .where((position) =>
                calculateDistance(currentLocation, position) <= 2.0)
            .map((position) => Marker(
                  markerId: MarkerId(position.toString()),
                  position: position,
                  icon: BitmapDescriptor.defaultMarker,
                  // Ajoutez d'autres détails de marqueur si nécessaire
                ))
            .toSet(),
      ),
    );
  }

  // Fonction pour calculer la distance entre deux positions
  double calculateDistance(LocationData location1, LatLng location2) {
    // Implémentez la logique de calcul de distance ici
    // Vous pouvez utiliser la formule de Haversine par exemple
    // Retournez la distance en kilomètres
    return 0.0;
  }
}


