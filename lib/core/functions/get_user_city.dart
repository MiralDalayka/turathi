
import 'dart:developer';

import 'package:geocode/geocode.dart';

Future<String> UserCity(
    {required double latitude, required double longitude}) async {
  String t = "NULL";
try{

  await GeoCode()
      .reverseGeocoding(latitude: latitude, longitude: longitude)
      .then((value) {
    t = value.city ?? "***";
  });
}catch(Exception){
  t = "Waiting";
  log(Exception.toString()+"#########");
}
  return t;
}
