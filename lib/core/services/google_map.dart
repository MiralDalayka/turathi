import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turathi/utils/shared.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../functions/get_current_location.dart';

class MapScreenLocation extends StatefulWidget {
  const MapScreenLocation({Key? key, required this.lon, required this.lat})
      : super(key: key);
  final double lon, lat;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreenLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: _getHeight(context),
            child: FutureBuilder(
              future: performNearbySearch().whenComplete(() => Navigator.of(context).pop()),
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
    // await _getCurrentLocation().then((currentPos) {
    //   setState(() {
    _launchMaps(
        userLatitude: sharedUser.latitude!,
        userLongitude: sharedUser.longitude!,
        placeLatitude:  widget.lat,
      placeLongitude:   widget.lon);
    //   }); //,
    // }).catchError((error) {
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       title: Text('Error'),
    //       content: Text('Failed to get current location: $error'),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: Text('OK'),
    //         ),
    //       ],
    //     ),
    //   );
    // });
  }

  @override
  void initState() {
    // _initMap();
    super.initState();
  }

  // Future<void> _initMap() async {
  //   await _getCurrentLocation().then((value) {}).catchError((error) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text('Error'),
  //         content: Text('Failed to get current location: $error'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }

  // Future<Position> _getCurrentLocation() async {
  //   await Permission.locationWhenInUse.request();
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     throw 'Location services are disabled.';
  //   }
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       throw 'Location permission denied.';
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     throw 'Location permission permanently denied.';
  //   }
  //   return await Geolocator.getCurrentPosition();
  // }

  void _launchMaps(
      {required double userLatitude,
      required double userLongitude,
      required double placeLatitude,
      required double placeLongitude}) async {
    var url = Uri.parse(
        "https://www.google.com/maps/dir/?api=1&origin=$userLatitude,$userLongitude&destination=$placeLatitude,$placeLongitude");
    await launchUrl(url);
  }
}
