import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turathi/utils/shared.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../functions/get_current_location.dart';

// open google map to track the destination
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
    _launchMaps(
        widget.lat, widget.lon, sharedUser.latitude!, sharedUser.longitude!);
  }

  @override
  void initState() {
    super.initState();
  }

  // connect with google map api
  void _launchMaps(double lat, double lon, double d, double a) async {
    final double myLatitude = lat; // user latitude
    final double myLongitude = lon; // user longitude
    final double destinationLatitude = d; // place latitude
    final double destinationLongitude = a; // place longitude
    var url = Uri.parse(
        "https://www.google.com/maps/dir/?api=1&origin=$myLatitude,$myLongitude&destination=$destinationLatitude,$destinationLongitude");
    await launchUrl(url);
  }
}
