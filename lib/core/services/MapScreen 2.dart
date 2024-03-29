import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turathi/utils/shared.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreenLocation extends StatefulWidget {
  const MapScreenLocation({Key? key, required this.lon, required this.lat})
      : super(key: key);
  final double lon, lat;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreenLocation> {
  Position? currentLocation;

  double? distance;
  double? bearing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: _getHeight(context),
            child: FutureBuilder(
              future: performNearbySearch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  double _getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.85;
  }

  Future<void> performNearbySearch() async {
    await _getCurrentLocation().then((currentPos) {
      setState(() {
        currentLocation = currentPos;

        userNearestLat = currentPos.latitude;
        userNearestLog= currentPos.longitude;
        
         distance = Geolocator.distanceBetween(
          currentPos.latitude,
          currentPos.longitude,
          widget.lat,
          widget.lon,
        );
        bearing = Geolocator.bearingBetween(
          currentPos.latitude,
          currentPos.longitude,
          widget.lat,
          widget.lon,
        );
        print('Current: ${currentPos.latitude} meters');
        print('Distance: $distance meters');
        print('Bearing: $bearing degrees');

        _launchMaps(
            widget.lon, widget.lat, 32.49517491030077, 35.991236423865466);
      }); //,
    }).catchError((error) {
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
    });
  }

  @override
  void initState() {
    _initMap();
    super.initState();
  }

  Future<void> _initMap() async {
    await _getCurrentLocation().then((value) {}).catchError((error) {
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
    });
  }

  Future<Position> _getCurrentLocation() async {
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

  void _launchMaps(double lat, double lon, double d, double a) async {
    final double myLatitude = lat; // 32.494564056396484;
    final double myLongitude = lon; //35.99126052856445  ;
    final double destinationLatitude = d; //34.0522;
    final double destinationLongitude = a; //-118.2437;
    final String url =
        "https://www.google.com/maps/dir/?api=1&origin=$myLatitude,$myLongitude&destination=$destinationLatitude,$destinationLongitude";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

//   void _createPolylines(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
//   PolylineId id = PolylineId('poly');
//   List<LatLng> polylineCoordinates = [];

//   polylineCoordinates.add(LatLng(startLatitude, startLongitude));
//   polylineCoordinates.add(LatLng(endLatitude, endLongitude));

//   Polyline polyline = Polyline(
//     polylineId: id,
//     color: Colors.red,
//     points: polylineCoordinates,
//     width: 5,
//   );

//   setState(() {
//     polylines.add(polyline);
//     LatLngBounds bounds = LatLngBounds(
//       southwest: LatLng(startLatitude, startLongitude),
//       northeast: LatLng(endLatitude, endLongitude),
//     );
//     mapController.animateCamera(
//       CameraUpdate.newLatLngBounds(bounds, 100),
//     );
//   });
// }
}
