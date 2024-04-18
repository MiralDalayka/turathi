import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turathi/utils/shared.dart';

class GetCurrentLocation {
  late Position _currentLocation;

  Future<Position> getCurrentLocation() async {
    await Permission.locationWhenInUse.request();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permission denied.';
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw 'Location permission permanently denied.';
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> performNearbySearch(BuildContext context) async {
    try {

      Position? currentPos = await getCurrentLocation();
      if (currentPos != null) {  // If the current position is null then show me error message
        _currentLocation = currentPos;
        userNearestLat = currentPos.latitude;
        userNearestLog = currentPos.longitude;
      } else {

        throw ('Failed to get current location');
      }
    } catch (error) {
      print("Failed to get current location: $error");

      _showErrorDialog(context, error.toString()); //error
    }
  }

  //  this is to show error
  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Failed to get current location: $errorMessage'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
