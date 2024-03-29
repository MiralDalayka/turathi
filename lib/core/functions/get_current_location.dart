import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turathi/utils/shared.dart';

class GetCurrentLocation {
  late Position currentLocation;

  Future<Position?> _getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  Future<void> performNearbySearch(BuildContext context) async {
    try {
      Position? currentPos = await _getCurrentLocation();
      if (currentPos != null) {
        currentLocation = currentPos;
        userNearestLat = currentPos.latitude;
        userNearestLog = currentPos.longitude;
      } else {
        throw ('Failed to get current location');
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to get current location: $error'),
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
}
