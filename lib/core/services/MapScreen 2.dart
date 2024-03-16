// ignore_for_file: unnecessary_string_interpolations, prefer_collection_literals, non_constant_identifier_names, library_private_types_in_public_api, use_super_parameters

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turathi/utils/theme_manager.dart';

//AIzaSyAoil6egyTbeRl_QsgScpxGzr13e9WXKu0

class MapScreenLocation extends StatefulWidget {
  const MapScreenLocation({Key? key, required this.lon, required this.lat})
      : super(key: key);
  final double lon, lat;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreenLocation> {
  late BitmapDescriptor myIcon;

  final String mapKey = "AIzaSyAoil6egyTbeRl_QsgScpxGzr13e9WXKu0";
  late GoogleMapController mapController;
  static late CameraPosition cam_pos;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Marker> markers = {};

  MapType currentMapType = MapType.hybrid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        leading: Container(
          padding: const EdgeInsets.all(0),
          child: Center(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_sharp,
                color: Colors.grey,
                size: 25,
              ),
            ),
          ),
        ),
        actions: [
          PopupMenuButton<MapType>(
            onSelected: (MapType result) {
              setState(() {
                currentMapType = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MapType>>[
              PopupMenuItem<MapType>(
                value: MapType.normal,
                child: Text('Normal'),
              ),
              PopupMenuItem<MapType>(
                value: MapType.satellite,
                child: Text('Satellite'),
              ),
              PopupMenuItem<MapType>(
                value: MapType.terrain,
                child: Text('Terrain'),
              ),
              PopupMenuItem<MapType>(
                value: MapType.hybrid,
                child: Text('Hybrid'),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: () {
              mapController.animateCamera(
                CameraUpdate.zoomIn(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: () {
              mapController.animateCamera(
                CameraUpdate.zoomOut(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height:_getHeight(context),
                  child: GoogleMap(
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    mapToolbarEnabled: false,
                    rotateGesturesEnabled: true,
                    tiltGesturesEnabled: false,
                    myLocationEnabled: true,
                    gestureRecognizers: Set()
                      ..add(Factory<PanGestureRecognizer>(
                          () => PanGestureRecognizer())),
                    mapType: currentMapType,
                    initialCameraPosition: cam_pos,
                    onMapCreated: (GoogleMapController controller) {
                      if (!_controller.isCompleted) {
                        _controller.complete(controller);
                        mapController = controller;
                        performNearbySearch(controller, 'your_place_type');
                      }
                    },
                    markers: markers,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.85;
  }

  Future<void> performNearbySearch(
      GoogleMapController controller, String placeType) async {
    LatLng currentPosition = LatLng(widget.lon, widget.lat);

    final Marker currentMarker = Marker(
      markerId: MarkerId("currentPosition"),
      position: currentPosition,
      infoWindow: InfoWindow(title: "Current Position"),
      onTap: () {},
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );

    markers.add(currentMarker);

    mapController.animateCamera(
      CameraUpdate.newLatLng(currentPosition),
    );

    setState(() {});
  }

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(0.1, 0.1)),
            'assets/images/img_png/location_marker.png')
        .then((onValue) {
      myIcon = onValue;
    });

    cam_pos = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(widget.lon, widget.lat),
      tilt: 0,
      zoom: 19,
    );

    super.initState();
  }
}