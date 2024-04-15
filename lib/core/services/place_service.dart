import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:turathi/core/models/place_model.dart';

class PlaceService {
  //create instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String collectionName = "places";

  //add -get - update visibility,modify info

  Future<String> addPlace(PlaceModel model) async {
    _fireStore
        .collection(collectionName)
        .add(model.toJson())
        .whenComplete(() => "Done")
        .catchError((error) {
      log(error.toString());
      return "Failed";
    });
    return "Done";
  }

  Future<PlaceList> getPlaces() async {
    QuerySnapshot placesData =
        await _fireStore.collection(collectionName).get().whenComplete(() {
      log("getPlaces done");
    }).catchError((error) {
      log(error.toString());
    });
    //map to store docs data in
    Map<String, dynamic> data = {};
    //temp model
    PlaceModel tempModel;
    //temp list
    PlaceList placeList = PlaceList(places: []);
    // log(placesData.docs[0].get('id').toString());
    for (var item in placesData.docs) {
      data["id"] = item.get("id");
      data["distance"] = item.get("distance"); //.....
      //.....
      tempModel = PlaceModel.fromJson(data);
      log(tempModel.distance.toString());

      placeList.places.add(tempModel);
    }
    log(placeList.places[0].toString());
    return placeList;
  }

 Future<PlaceModel> updatePlace(PlaceModel placeModel) async {
    QuerySnapshot placesData = await _fireStore
        .collection(collectionName)
        .where('id', isEqualTo: placeModel.id)
        .get();
    String placeId = placesData.docs[0].id; //id for the ref
    _fireStore
        .collection(collectionName)
        .doc(placeId)
        .update(placeModel.toJson())
        .whenComplete(() {
      log("UPDATE done");
    }).catchError((error) {
      log(error.toString());
    });
    return placeModel;
  }
}

