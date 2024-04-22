import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/services/place_service.dart';

import '../functions/calculate_distanceInKm.dart';
import '../models/place_model.dart';

class PlaceProvider extends ChangeNotifier {
  final PlaceService _placeService = PlaceService();


  Future<String> addPlace({required PlaceModel model, required List<XFile> images}) async {
    String msg = (await _placeService.addPlace(model: model,images: images).whenComplete(() {
      notifyListeners();

    }));
    return msg;
  }



  Future<PlaceList> getPlaces() async {
    return await  _placeService.getPlaces();
  }

  Future<PlaceModel> updatePlace(PlaceModel model) async {
    return await _placeService.updatePlace(model).whenComplete(() {
      notifyListeners();
    });
  }
  Future<PlaceList> createNearestPlaceList(selectedNearestLat, selectedNearestLog)async {

   List<PlaceModel> nearestPlaces=[];
 PlaceList places =await getPlaces() ;

    nearestPlaces = places.places.where((place) {
      double distanceInKm = calculateDistanceInKm(
        lat1:      place.latitude!,
        lon1:  place.longitude!,
        lat2:  selectedNearestLat,
        lon2:   selectedNearestLog,
      );
      return distanceInKm <= 10;
    }).toList();
   notifyListeners();

   return PlaceList(places: nearestPlaces);
  }
  Future<PlaceList> getMostPopularPlaces()async {

    PlaceList places =await getPlaces() ;
    final temp;
    if(places.places.length>=10) {
      temp= places.places.getRange(0, 9);
    } else {
      temp= places.places.getRange(0, places.places.length-1);
    }


    return PlaceList(places: temp.toList() );
  }
}