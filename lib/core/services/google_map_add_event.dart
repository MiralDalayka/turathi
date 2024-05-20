import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/providers/place_provider.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/shared.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/widgets/deff_button%203.dart';


class AddEventMap extends StatefulWidget {
  const AddEventMap({Key? key}) : super(key: key);

  @override
  _AddEventMapState createState() => _AddEventMapState();
}

class _AddEventMapState extends State<AddEventMap> {
  late GoogleMapController mapController;
  late CameraPosition cam_pos =
  CameraPosition(target: LatLng(sharedUser.latitude!,sharedUser.longitude!), zoom: 13);

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Marker> markers = {};

  MapType currentMapType = MapType.hybrid;

  Position? currentLocation;

  double? distance;
  double? bearing;

  bool markerAdded = false;


  @override
  Widget build(BuildContext context) {
    var placesProvider = Provider.of<PlaceProvider>(context);

    return Scaffold(
      appBar: AppBar(
           backgroundColor: ThemeManager.background,
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
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              mapType: currentMapType,
              initialCameraPosition: cam_pos,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapController = controller;
              },
              onTap: _handleTap,
              markers: markers,
            ),
          ),
          if (markerAdded) // Show me the button if the marker is added
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(
                    LayoutManager.widthNHeight0(context, 1) * 0.15),
                child: defaultButton3(
                  text: '       Done       ',
                  width: LayoutManager.widthNHeight0(context, 1) * 0.45,
                  borderRadius: 18,
                  background: ThemeManager.primary,
                  textColor: ThemeManager.second,
                  onPressed: () {
                   
                    log("From done button ");

                    Navigator.of(context).pop();
                 
                  },
                  borderWidth: 0,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _handleTap(LatLng tappedPoint) {
    setState(() {
      markers.clear();
      markers.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
      markerAdded = true;
    });

    print(
        'Latitude: ${tappedPoint.latitude}, Longitude: ${tappedPoint.longitude}');
        
    addEventLocatonLat = tappedPoint.latitude;
    addEventLocatonLog = tappedPoint.longitude;

    //////back
  }

  @override
  void initState() {
    // _initMap();
    super.initState();
  }

  // Future<void> _initMap() async {
  //   await _getCurrentLocation().then((value) {});
  // }

  // Future<Position> _getCurrentLocation() async {
  //   try {
  //     await Permission.locationWhenInUse.request();
  //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //
  //     if (!serviceEnabled) {
  //       throw 'Location services are disabled.';
  //     }
  //
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         throw 'Location permission denied.';
  //       }
  //     }
  //
  //     if (permission == LocationPermission.deniedForever) {
  //       throw 'Location permission permanently denied.';
  //     }
  //
  //     return await Geolocator.getCurrentPosition();
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
}
