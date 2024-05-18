
import 'dart:math';

import 'package:flutter_map_math/flutter_geo_math.dart';
// double getDistanceInKm(
//     {required double lat1,required double lon1,required double lat2,required double lon2}){
//   return FlutterMapMath().distanceBetween(
//       lat1,
//       lon2,
//       lat2,
//       lon2,
//       "kilometers"
//   );
//
// }

double getDistanceInKm(
    {required double lat1,required double lon1,required double lat2,required double lon2}) {
  const double earthRadius = 6371.0;//in km


  double radiansLat1 = _degreesToRadians(lat1);
  double radiansLon1 = _degreesToRadians(lon1);
  double radiansLat2 = _degreesToRadians(lat2);
  double radiansLon2 = _degreesToRadians(lon2); //degrees to radians


  double dLat = radiansLat2 - radiansLat1;
  double dLon = radiansLon2 - radiansLon1; //diff

  // Calcul the distance usee (Haversine formula)
  double a = pow(sin(dLat / 2), 2) +
      cos(radiansLat1) * cos(radiansLat2) * pow(sin(dLon / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = earthRadius * c; // Distance in kilometers

  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}

double getFormattedDistance(double distance,int distance_chos) {
  if (distance < 1) {
    return -1;
  } else if (distance < distance_chos) {
    return -distance_chos*0.0;
  } else {
    return distance;
  }
}