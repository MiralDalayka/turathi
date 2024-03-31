import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turathi/utils/shared.dart';

class GetCurrentLocation {
  late Position currentLocation;

  Future<Position?> _getCurrentLocation() async {
    try {
      // req permission to access the device's location
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // If permission is denied then return null
        return null;
      }

     
      return await Geolocator.getCurrentPosition( //this is to get user current position
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
      if (currentPos != null) {  // If the current position is null then show me error message
        currentLocation = currentPos;
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
