import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/services/file_storage_service.dart';
import 'package:turathi/core/services/place_service.dart';

import '../../utils/shared.dart';
import '../functions/calculate_distanceInKm.dart';
import '../models/place_model.dart';

class PlaceProvider extends ChangeNotifier {
  final PlaceService _placeService = PlaceService();

  PlaceList _placeList = PlaceList(places: []);

  Future<PlaceList> get placeList async {
    if (_placeList.places.isEmpty) {
      await _getPlaces();
    }
    log(_placeList.places.length.toString());
    return _placeList;
  }

  Future<String> addPlace(
      {required PlaceModel model, required List<XFile> images}) async {
    _placeList.places.add(await _placeService
        .addPlace(model: model, images: images)
        .whenComplete(() async {
      log("Add place successfully");
      notifyListeners();
    }));

    log(_placeList.places.length.toString());

    return "Done";
  }

  Future<void> _getPlaces() async {
    _placeList = await _placeService
        .getPlaces()
        .whenComplete(() => {log("Provider get places")});
  }

  Future<PlaceModel> updatePlace(
      {required PlaceModel placeModel, required List<XFile> images}) async {
    log(placeModel.toJson().toString());
    int index = _placeList.places.indexOf(placeModel);
    _placeList.places[index] = await _placeService
        .updatePlace(placeModel: placeModel, images: images)
        .whenComplete(() {
      notifyListeners();
    });
    return placeModel;
  }

  Future<PlaceModel> likePlace(String id) async {
    // int index = _placeList.places.indexOf(placeModel);
    var index = _placeList.places.indexWhere((element) => element.id == id);
    log("INDEX $index");

    PlaceModel temp=   await _placeService.likePlace(id!).whenComplete(() async {
      await getMostPopularPlaces();
    });
    _placeList.places[index] =temp;

    notifyListeners();
    return temp;
  }

  Future<PlaceModel> dislikePlace(String id) async {
    var index = _placeList.places.indexWhere((element) => element.id == id);


    PlaceModel temp=   await _placeService.dislikePlace(id!).whenComplete(() async {
      await getMostPopularPlaces();
    });
    _placeList.places[index] =temp;
///

    notifyListeners();
    return temp;
  }


  Future<PlaceList> getNearestPlaceList(
      selectedNearestLat, selectedNearestLog, distanceValue) async {
    List<PlaceModel> nearestPlaces = [];
    PlaceList places = _placeList;

   // nearestPlaces = places.places.where((element) => element.distance! <= distanceValue).toList();
    
    nearestPlaces = places.places.where((element) => element.distance != null && element.distance! <= distanceValue).toList();

    // nearestPlaces = places.places.where((place) {
    //   double distanceInKm = getFormattedDistance(
    //       calculateDistanceInKm(
    //         lat1: place.latitude!,
    //         lon1: place.longitude!,
    //         lat2: selectedNearestLat,
    //         lon2: selectedNearestLog,
    //       ),
    //       dis_num);
    //   log(distanceInKm.toString());
    //   return distanceInKm <= dis_num;
    // }).toList();

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

  updatePosition(lat, long) {
    selectedNearestLat = lat;
    selectedNearestLog = long;
    notifyListeners();
  }
  //test this function
  PlaceList getFavPlaces(places){
    List<PlaceModel> tempList=[];

    for(String id in sharedUser.favList!){
      var tempModel =places.firstWhere((element) => element.id==id,orElse:()=>PlaceModel.empty());

   tempList.add(tempModel);

    }
    return PlaceList(places: tempList);
  }
}
