import 'package:geocode/geocode.dart';
// return the user current city based on his location
Future<String> UserCity(
    {required double latitude, required double longitude}) async {
  String t = "NULL";
  // using GeoCode Package
  await GeoCode()
      .reverseGeocoding(latitude: latitude, longitude: longitude)
      .then((value) {
    t = value.city ?? "***";
  });
  return t;
}
