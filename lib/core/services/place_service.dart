import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/core/services/comment_service.dart';
import 'package:turathi/core/services/file_storage_service.dart';

import '../../utils/shared.dart';
import 'file_storage_service.dart';

class PlaceService {
  //create instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "places";
  final FilesStorageService _filesStorageService = FilesStorageService();

  //add -get - update visibility,modify info

  Future<String> addPlace(PlaceModel model, List<XFile> images) async {
    _fireStore.collection(_collectionName).add(model.toJson()).whenComplete(() async {
      _filesStorageService.uploadImages(
          folderName: model.title!, pickedImages: images!);


    }).catchError((error) {
      log("$error%%%");
      return "Failed";
    });
    return "Done";
  }

  Future<PlaceList> getPlaces() async {
    QuerySnapshot placesData =
        await _fireStore.collection(_collectionName).get().whenComplete(() {
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
      data["userID"] = item.get("userID");
      data["state"] = item.get("state");
      data["address"] = item.get("address");
      data["status"] = item.get("status");
      data["description"] = item.get("description");
      data["title"] = item.get("title");
      data["latitude"] = item.get("latitude");
      data["longitude"] = item.get("longitude");
      data["isVisible"] = item.get("isVisible");
      data["disLike"] = item.get("disLike");
      data["like"] = item.get("like");

      tempModel = PlaceModel.fromJson(data);
      tempModel.images =
      await _filesStorageService.getImages(imageType:ImageType.placeImages.name,
          folderName: tempModel.title!);

      placeList.places.add(tempModel);
    }
    log(placeList.places[0].toString());
    return placeList;
  }

  Future<PlaceModel> updatePlace(PlaceModel placeModel) async {
    QuerySnapshot placesData = await _fireStore
        .collection(_collectionName)
        .where('id', isEqualTo: placeModel.id)
        .get();
    String placeId = placesData.docs[0].id; //id for the ref
    _fireStore
        .collection(_collectionName)
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
