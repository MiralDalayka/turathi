import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/services/place_service.dart';

import '../../utils/shared.dart';
import '../functions/calculate_distanceInKm.dart';
import '../models/place_model.dart';

class PlaceProvider extends ChangeNotifier {
  final PlaceService _placeService = PlaceService();
  late PlaceList _placeList;

PlaceProvider() {
  // _placeList = PlaceList(places: []); //this to fix eror
  _getPlaces();
}

  

  Future<PlaceList> get placeList async {
    if (_placeList == null) {
      await _getPlaces();
    }
    return _placeList;
  }

  Future<String> addPlace(
      {required PlaceModel model, required List<XFile> images}) async {
    String msg = (await _placeService
        .addPlace(model: model, images: images)
        .whenComplete(() {
      _getPlaces();
      notifyListeners();
    }));
    return msg;
  }

  Future<void> _getPlaces() async {
    _placeList = await _placeService.getPlaces();
  }

  Future<PlaceModel> updatePlace(PlaceModel model) async {
    return await _placeService.updatePlace(model).whenComplete(() {
      notifyListeners();
    });
  }

  Future<PlaceList> getNearestPlaceList(
      selectedNearestLat, selectedNearestLog) async {
    List<PlaceModel> nearestPlaces = [];
    PlaceList places = _placeList;

    nearestPlaces = places.places.where((place) {
      double distanceInKm = getFormattedDistance(calculateDistanceInKm(
        lat1: place.latitude!,
        lon1: place.longitude!,
        lat2: selectedNearestLat,
        lon2: selectedNearestLog,
      ));
      log(distanceInKm.toString());
      return distanceInKm <= 10;
    }).toList();

    return PlaceList(places: nearestPlaces);
  }

  Future<PlaceList> getMostPopularPlaces() async {
    PlaceList places = _placeList;
    final temp;
    if (places.places.length >= 10) {
      temp = places.places.getRange(0, 9);
    } else {
      temp = places.places.getRange(0, places.places.length - 1);
    }

    return PlaceList(places: temp.toList());
  }

  updatePosition(lat,long){
    selectedNearestLat = lat;
    selectedNearestLog= long;
    notifyListeners();
  }
}
