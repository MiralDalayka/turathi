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
    bool exists = await _placeService.placeExists(model.title.toString());

    if (exists) {
      log("Place with title ${model.title} already exists");
      return "Place already exists";
    }

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
    log("INDEX $index");
    _placeList.places[index] = await _placeService
        .updatePlace(placeModel: placeModel, images: images)
        .whenComplete(() {
      notifyListeners();
      log("update place list");
    });
    return placeModel;
  }
  // Future<PlaceModel> updatePlace({
  //   required PlaceModel placeModel,
  //   required List<XFile> images,
  // }) async {
  //   log(placeModel.toJson().toString());
  //   int index = _placeList.places.indexOf(placeModel);
  //   log("INDEX $index");
  //   if (index != -1) {
  //     _placeList.places[index] = await _placeService
  //         .updatePlace(placeModel: placeModel, images: images)
  //         .whenComplete(() {
  //       notifyListeners();
  //     });
  //   } else {
  //     log('PlaceModel not found in the list');
  //   }
  //   return placeModel;
  // }

  Future<PlaceModel> likePlace(String id) async {
    // int index = _placeList.places.indexOf(placeModel);
    var index =
        _placeList.places.indexWhere((element) => element.placeId == id);
    log("INDEX $index");

    PlaceModel temp = await _placeService.likePlace(
        id!, _placeList.places[index].likesList!.length);
    _placeList.places[index] = temp;
    await getMostPopularPlaces();
    notifyListeners();
    return temp;
  }

  Future<PlaceModel> dislikePost(String id) async {
    var index =
        _placeList.places.indexWhere((element) => element.placeId == id);

    PlaceModel temp = await _placeService.disLikePlace(
        id!, _placeList.places[index].likesList!.length);
    _placeList.places[index] = temp;

    await getMostPopularPlaces();
    notifyListeners();
    return temp;
  }

  Future<PlaceList> getNearestPlaceList(
      selectedNearestLat, selectedNearestLog, distanceValue) async {
    List<PlaceModel> nearestPlaces = [];
    PlaceList places = _placeList;

    nearestPlaces = places.places.where((place) {
      double distanceInKm = getDistanceInKm(
        lat1: place.latitude!,
        lon1: place.longitude!,
        lat2: selectedNearestLat,
        lon2: selectedNearestLog,
      );
      log(distanceInKm.toString());
      return distanceInKm <= distanceValue;
    }).toList();

    return PlaceList(places: nearestPlaces);
  }

  Future<PlaceList> getMostPopularPlaces() async {
    PlaceList places = await placeList;
    if(places.places.isNotEmpty){
      if (places.places.length >= 10) {
        return PlaceList(places: places.places.getRange(0, 9).toList());
      }
      log(places.places.getRange(0, places.places.length).first.title! + "{{{{");

      return places;
    }
    return PlaceList(places: []);
  }

  updatePosition(lat, long) {
    selectedNearestLat = lat;
    selectedNearestLog = long;
    notifyListeners();
  }

  deletePlace(PlaceModel place_model) {
    _placeList.places.remove(place_model);
    _placeService.deletePlace(placeModel: place_model).whenComplete(() {
      notifyListeners();

    });
  }

  //test this function
  PlaceList getFavPlaces(places) {
    List<PlaceModel> tempList = [];

    for (String id in sharedUser.favList!) {
      PlaceModel tempModel = places.firstWhere(
          (element) => element.placeId == id,
          orElse: () => PlaceModel.empty());
      if (tempModel.placeId != "-1" || tempModel.isVisible == false) {
        tempList.add(tempModel);
      }
    }
    return PlaceList(places: tempList);
  }
}
