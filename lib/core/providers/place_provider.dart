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

  // Future<PlaceModel> likePost(String id) async {
  //   // int index = _placeList.places.indexOf(placeModel);
  //   var index = _placeList.places.indexWhere((element) => element.id == id);
  //   log("INDEX $index");
  //
  //   PlaceModel temp=   await _placeService.likePost(id!).whenComplete(() async {
  //     await getMostPopularPlaces();
  //   });
  //   _placeList.places[index] =temp;
  //
  //   notifyListeners();
  //   return temp;
  // }

//   Future<PlaceModel> dislikePost(String id) async {
//     var index = _placeList.places.indexWhere((element) => element.id == id);
//
//
//     PlaceModel temp=   await _placeService.dislikePost(id!).whenComplete(() async {
//       await getMostPopularPlaces();
//     });
//     _placeList.places[index] =temp;
// ///
//
//     notifyListeners();
//     return temp;
//   }

  Future<String> addLike(PlaceModel placeModel) async {
    // placeModel.like = placeModel.like! + 1;
    if (placeModel.like! > 5) {
      placeModel.state = PlaceState.TrustWorthy.name;
    }
    int index = _placeList.places.indexOf(placeModel);
    _placeList.places[index] = await _placeService
        .updatePlace(placeModel: placeModel)
        .whenComplete(() async {
      await getMostPopularPlaces();
    });
    return "Done";
  }

  Future<String> deleteLike(PlaceModel placeModel) async {
    // int dilikes = placeModel.like! -1;
    // if(dilikes<0) {
    //   return "Failed";
    // }
    // placeModel.disLike = dilikes;

    int index = _placeList.places.indexOf(placeModel);
    _placeList.places[index] = await _placeService
        .updatePlace(placeModel: placeModel)
        .whenComplete(() async {
      await getMostPopularPlaces();
    });
    return "Done";
  }

  Future<String> addDislike(PlaceModel placeModel) async {
    placeModel.disLike = placeModel.disLike! + 1;

    int index = _placeList.places.indexOf(placeModel);
    _placeList.places[index] = await _placeService
        .updatePlace(placeModel: placeModel)
        .whenComplete(() async {
      await getMostPopularPlaces();
    });
    return "Done";
  }

  Future<String> deleteDislike(PlaceModel placeModel) async {
    int dislikes = placeModel.disLike! - 1;
    if (dislikes < 0) {
      return "Failed";
    }
    placeModel.disLike = dislikes;

    int index = _placeList.places.indexOf(placeModel);
    _placeList.places[index] = await _placeService
        .updatePlace(placeModel: placeModel)
        .whenComplete(() async {
      await getMostPopularPlaces();
    });
    return "Done";
  }

  Future<PlaceList> getNearestPlaceList(
      selectedNearestLat, selectedNearestLog, dis_num) async {
    List<PlaceModel> nearestPlaces = [];
    PlaceList places = _placeList;

    nearestPlaces = places.places.where((place) {
      double distanceInKm = getFormattedDistance(
          calculateDistanceInKm(
            lat1: place.latitude!,
            lon1: place.longitude!,
            lat2: selectedNearestLat,
            lon2: selectedNearestLog,
          ),
          dis_num);
      log(distanceInKm.toString());
      return distanceInKm <= dis_num;
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

  updatePosition(lat, long) {
    selectedNearestLat = lat;
    selectedNearestLog = long;
    notifyListeners();
  }
}
