import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreenLocation extends StatefulWidget {
  const MapScreenLocation({Key? key, required this.lon, required this.lat})
      : super(key: key);
  final double lon, lat;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreenLocation> {
  late GoogleMapController mapController;
  late CameraPosition cam_pos = CameraPosition(target: LatLng(0, 0)); 

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Marker> markers = {};

  MapType currentMapType = MapType.hybrid;

  Position? currentLocation;

  double? distance;
  double? bearing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.grey,
            size: 25,
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
              const PopupMenuItem<MapType>(
                value: MapType.normal,
                child: Text('Normal'),
              ),
              const PopupMenuItem<MapType>(
                value: MapType.satellite,
                child: Text('Satellite'),
              ),
              const PopupMenuItem<MapType>(
                value: MapType.terrain,
                child: Text('Terrain'),
              ),
              const PopupMenuItem<MapType>(
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
            SizedBox(
              height: _getHeight(context),
              child: GoogleMap(
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                mapType: currentMapType,
                initialCameraPosition: cam_pos,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  mapController = controller;
                  performNearbySearch(controller, 'your_place_type');
                },
                markers: markers,
              ),
            ),
            SizedBox(height: 20),
            if (distance != null)
              Text(
                'Distance: ${distance!.toStringAsFixed(2)} meters',
                style: TextStyle(fontSize: 16),
              ),
            if (bearing != null)
              Text(
                'Bearing: ${bearing!.toStringAsFixed(2)} degrees',
                style: TextStyle(fontSize: 16),
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


    await _getCurrentLocation().then((currentPos) {
      setState(() {
        currentLocation = currentPos;
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
      });
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
    await _getCurrentLocation().then((value) {
      setState(() {
        cam_pos = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(widget.lon, widget.lat),
          tilt: 0,
          zoom: 19,
        );
      });
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
}
