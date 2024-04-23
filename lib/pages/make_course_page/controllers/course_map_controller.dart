import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);

  void onMapTap(LatLng location) {
    selectedLocation.value = location;
  }


}
