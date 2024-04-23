import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart' as geocoding;
import '../../../constants.dart';
import '../../../providers/theme/theme.dart';

class CourseMapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<CourseMapPage> {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  final List<LatLng> polylineCoordinates = [];
  LatLng? departureLocation;
  LatLng? destinationLocation;
  final polylinePoints = PolylinePoints();
  final location.Location _location = location.Location();
  location.LocationData? currentLocation;
  String? departurePlaceName;
  String? destinationPlaceName;
  final TextEditingController _departureAddressController = TextEditingController();
  final TextEditingController _destinationAddressController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  void initState() {
    super.initState();
    _getLocation();
    _scaffoldKey.currentState?.openEndDrawer();
    _location.onLocationChanged.listen((location.LocationData currentLoc) {
      setState(() {
        currentLocation = currentLoc;
        markers.removeWhere((m) => m.markerId.value == "current_location");
        markers.add(Marker(
          markerId: MarkerId("current_location"),
          position: LatLng(currentLoc.latitude!, currentLoc.longitude!),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(title: "Position Actuelle"),
        ));
        mapController.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(currentLoc.latitude!, currentLoc.longitude!),
          ),
        );
      });
    });
  }

  Widget buildDrawer(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
            ),
            child: Text(
              'Enter Addresses',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: TextField(
              controller: _departureAddressController,
              decoration: InputDecoration(
                  labelText: 'Departure',
                  border: OutlineInputBorder()
              ),
            ),
          ),
          ListTile(
            title: TextField(
              controller: _destinationAddressController,
              decoration: InputDecoration(
                  labelText: 'Destination',
                  border: OutlineInputBorder()
              ),
            ),
          ),
          ListTile(
            title: ElevatedButton(
              child: Text('Search and Mark on Map', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              onPressed: () {
                _searchAndNavigate();
                Navigator.of(context).pop();  // Close the drawer
              },
              style: ElevatedButton.styleFrom(
                //surfaceTintColor: Colors.white,
                  textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  elevation: 0,
                  backgroundColor: AppTheme.otripMaterial,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('choose_your_address'.tr),
       /* actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {

              _scaffoldKey.currentState?.openEndDrawer(); // Opens the end drawer
              buildDrawer();
            },
          ),
        ],*/
      ),
      endDrawer: buildDrawer(),
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator(color: Colors.deepOrange,))
          :Column(
          children: [
            SizedBox(height: 18.0,),
            Text(
              'Choisissez vos lieux sur la carte ou effectuez des recherches en cliquant sur le menu',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 18.0,),
            Expanded(
              child: Stack(
                  children: [ GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                      zoom: 13.5,
                    ),
                    onTap: _onMapTapped,
                    markers: Set<Marker>.of(markers),
                    polylines: {
                      if (polylineCoordinates.isNotEmpty)
                        Polyline(
                          polylineId: PolylineId('route'),
                          color: Colors.orange,
                          points: polylineCoordinates,
                          width: 5,
                        ),
                    },
                  ),
                   /* Positioned(
                      top: 18.0,
                      right: 18.0,
                      child: FloatingActionButton(
                        onPressed: () {
                          buildDrawer();
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Icon(Icons.search, color: Colors.deepOrange),
                        backgroundColor: Colors.white,
                      ),
                    ),*/
                  ]),
            ),
            ElevatedButton(
              onPressed: (){
                if (departurePlaceName != null && destinationPlaceName != null) {
                  print('Départ de: $departurePlaceName');
                  print('Arrivée à: $destinationPlaceName');
                  GetStorage().write('departLieu', departurePlaceName);
                  GetStorage().write('arriveeLieu', destinationPlaceName);
                          final enginData = GetStorage();
                          String engin = enginData.read('engin');
                          if (engin == 'Voiture') {
                            Get.toNamed('/voiture');
                          } else if (engin == 'Moto') {
                            Get.toNamed('/moto');
                          } else if (engin == 'Tricycle') {
                            Get.toNamed('/tricycle');
                          }
                }
              },
              child: Text('choose_a_driver'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.white)),
              style: ElevatedButton.styleFrom(
                //surfaceTintColor: Colors.white,
                  textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  elevation: 0,
                  backgroundColor: AppTheme.otripMaterial,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))
              ),
            )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearMap,
        child: Icon(Icons.refresh, color: Colors.white,),
        backgroundColor: Colors.deepOrange,

      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapTapped(LatLng location) {
    setState(() {
      if (departureLocation == null) {
        departureLocation = location;
        markers.add(Marker(
          markerId: MarkerId('departure'),
          position: location,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: "Départ"),
        ));
        _getPlaceName(location.latitude, location.longitude, "departure");
      } else if (destinationLocation == null) {
        destinationLocation = location;
        markers.add(Marker(
          markerId: MarkerId('destination'),
          position: location,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: "Arrivée"),
        ));
        _getPolyline();
        _getPlaceName(location.latitude, location.longitude, "destination");
      }
    });
  }

  void _searchAndNavigate() async {
    try {
      List<geocoding.Location> departureLocations = await geocoding.locationFromAddress(_departureAddressController.text);
      List<geocoding.Location> destinationLocations = await geocoding.locationFromAddress(_destinationAddressController.text);

      if (departureLocations.isNotEmpty && destinationLocations.isNotEmpty) {
        setState(() {
          departureLocation = LatLng(departureLocations.first.latitude, departureLocations.first.longitude);
          destinationLocation = LatLng(destinationLocations.first.latitude, destinationLocations.first.longitude);

          markers.add(Marker(
            markerId: MarkerId('departure'),
            position: departureLocation!,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: InfoWindow(title: 'Departure'),
          ));
          markers.add(Marker(
            markerId: MarkerId('destination'),
            position: destinationLocation!,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(title: 'Destination'),
          ));

          mapController.animateCamera(
            CameraUpdate.newLatLngBounds(
              LatLngBounds(
                southwest: departureLocation!,
                northeast: destinationLocation!,
              ),
              50.0,
            ),
          );
          _getPolyline();
          _getPlaceName(departureLocation!.latitude, departureLocation!.longitude, "departure");
          _getPlaceName(destinationLocation!.latitude, destinationLocation!.longitude, "destination");

          _getPolyline();
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }


  Future<void> _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(departureLocation!.latitude, departureLocation!.longitude),
      PointLatLng(destinationLocation!.latitude, destinationLocation!.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      setState(() {
        polylineCoordinates.addAll(
          result.points.map((point) => LatLng(point.latitude, point.longitude)).toList(),
        );
      });
    }
  }

  void _clearMap() {
    setState(() {
      markers.clear();
      polylineCoordinates.clear();
      departureLocation = null;
      destinationLocation = null;
    });
  }

  void _getLocation() async {
    bool serviceEnabled;
    location.PermissionStatus permission;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permission = await _location.hasPermission();
    if (permission == location.PermissionStatus.denied) {
      permission = await _location.requestPermission();
      if (permission != location.PermissionStatus.granted) {
        return;
      }
    }

    final locData = await _location.getLocation();
    setState(() {
      currentLocation = locData;
      // Ajouter un marqueur pour la position actuelle
      markers.add(Marker(
        markerId: MarkerId("current_location"),
        position: LatLng(locData.latitude!, locData.longitude!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: "Position Actuelle"),
      ));
      // Centrer la carte sur la position actuelle
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(locData.latitude!, locData.longitude!),
            zoom: 18.0,
          ),
        ),
      );
    });
  }

  Future<void> _getPlaceName(double latitude, double longitude, String markerType) async {
    try {
      List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        geocoding.Placemark place = placemarks.first;
        String formattedPlaceName = "${place.street}, ${place.locality}, ${place.country}";
        print("Place name: $formattedPlaceName");

        if (markerType == "departure") {
          setState(() {
            departurePlaceName = formattedPlaceName;
          });
        } else if (markerType == "destination") {
          setState(() {
            destinationPlaceName = formattedPlaceName;
          });
        }
      }
    } catch (e) {
      print("Failed to get place name: $e");
    }
  }

}
