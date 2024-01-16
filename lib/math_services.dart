import 'dart:math';

import 'package:otrip/constants.dart';

class MathServices {
  String calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    // Conversion des latitudes et longitudes de degrés à radians
    final double lat1Rad = degreesToRadians(lat1);
    final double lng1Rad = degreesToRadians(lng1);
    final double lat2Rad = degreesToRadians(lat2);
    final double lng2Rad = degreesToRadians(lng2);

    // Calcul des différences de coordonnées
    final double deltaLat = lat2Rad - lat1Rad;
    final double deltaLng = lng2Rad - lng1Rad;

    // Formule haversine pour calculer la distance
    final double a = pow(sin(deltaLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(deltaLng / 2), 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Distance en kilomètres
    final double distance = earthRadius * c;
    String formattedDistance = distance.toStringAsFixed(2);

    return formattedDistance;

  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
