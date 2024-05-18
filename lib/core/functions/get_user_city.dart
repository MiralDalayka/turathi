import 'package:geocode/geocode.dart';

Future<String> UserCity(
    {required double latitude, required double longitude}) async {
  String t = "NULL";
  await GeoCode()
      .reverseGeocoding(latitude: latitude, longitude: longitude)
      .then((value) {
    t = value.city ?? "***";
  });
  return t;
}
