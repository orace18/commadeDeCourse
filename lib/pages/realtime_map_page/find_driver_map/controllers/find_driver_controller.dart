import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class FindDriverOnMapController extends GetxController{

  Future<String> getPlaceName(double latitude, double longitude) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(latitude, longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      String name = place.name ?? "";
      String locality = place.locality ?? "";
      String administrativeArea = place.administrativeArea ?? "";
      String country = place.country ?? "";
      return "$name, $locality, $administrativeArea, $country";
    } else {
      return "Nom du lieu non trouvé";
    }
  }
}