// import 'package:flutter/cupertino.dart';
// import 'package:turathi/core/services/place_service.dart';
//
// import '../models/place_model.dart';
//
// class PlaceProvider extends ChangeNotifier {
//   final PlaceService _placeService = PlaceService();
//
//   //get add update
//
//   Future<String> addPlace(PlaceModel model) async {
//     String msg = (await _placeService.addPlace(model).whenComplete(() {
//       notifyListeners();
//     }));
//     return msg;
//   }
//
//   Future<PlaceList> getPlaces() async {
//     //check
//     return await _placeService.getPlaces();
//   }
//
//   Future<PlaceModel> updatePlace(PlaceModel model) async {
//     return await _placeService.updatePlace(model).whenComplete(() {
//       notifyListeners();
//     });
//   }
// }
