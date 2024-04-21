import 'package:flutter/foundation.dart';
import 'package:turathi/core/models/place_model.dart';

import '../functions/calculate_distanceInKm.dart';
/*
this class needs more functions
 */
class NearestPlacesProvider with ChangeNotifier {
   List<PlaceModel> _nearestPlaces =[];


  List<PlaceModel> get nearestPlacesList {
    return _nearestPlaces;
  }
   int get itemsCount => _nearestPlaces.length;

  void createNearestPlaceList(selectedNearestLat, selectedNearestLog) {
    //need to be changed BACK
    /*
    this code should be in service as functions
    the demoPlaces should be a list in data base
    new code will be:
    1. call the function
    2. notifyListeners();

     */
    _nearestPlaces = demoPlaces.where((place) {
      double distanceInKm = calculateDistanceInKm(
   lat1:      place.latitude!,
        lon1:  place.longitude!,
       lat2:  selectedNearestLat,
       lon2:   selectedNearestLog,
      );
      return distanceInKm <= 10;
    }).toList();
    notifyListeners();
  }
}
