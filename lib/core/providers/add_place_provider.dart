import 'package:flutter/foundation.dart';
import 'package:turathi/core/models/place_model.dart';

import '../functions/calculate_distanceInKm.dart';
/*
this class needs more functions
 */
class AddPlacesProvider with ChangeNotifier {
   List<PlaceModel> _AddPlaces =[];


  List<PlaceModel> get addPlacesList {
    return _AddPlaces;
  }
   int get itemsCount => _AddPlaces.length;

  void createAddPlacesList(addPlaceLocatonLat, addPlaceLocatonLong) {
    //need to be changed BACK
    /*
    this code should be in service as functions
    the demoPlaces should be a list in data base
    new code will be:
    1. call the function
    2. notifyListeners();

     */
    _AddPlaces = demoPlaces.where((place) {
      double distanceInKm = calculateDistanceInKm(
        place.late!,
        place.long!,
        addPlaceLocatonLat,
        addPlaceLocatonLong,
      );
      return distanceInKm <= 10;
    }).toList();
    notifyListeners();
  }
}
