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

  Future<PlaceModel> addPlace({required PlaceModel model, required List<XFile> images}) async {
    model.images = await _filesStorageService.uploadImages(
        imageType: ImageType.placesImages.name,folderName: model.title!, pickedImages: images!)
    .whenComplete(() => {
     _fireStore.collection(_collectionName).add(model.toJson()).whenComplete(() =>
     {
     })
    });


    return model;
  }
  Future<PlaceModel> getPlaceByUserId(String userID) async{
    QuerySnapshot placeData = await _fireStore
        .collection(_collectionName)
        .where('userID', isEqualTo: userID)
        .get();
    Map<String, dynamic> data = {};

    PlaceModel tempModel;
    data["id"] = placeData.docs[0].get("id");
    data["userID"] = placeData.docs[0].get("userID");
    data["state"] = placeData.docs[0].get("state");
    data["address"] = placeData.docs[0].get("address");
    data["status"] = placeData.docs[0].get("status");
    data["description"] = placeData.docs[0].get("description");
    data["title"] = placeData.docs[0].get("title");
    data["latitude"] = placeData.docs[0].get("latitude");
    data["longitude"] = placeData.docs[0].get("longitude");
    data["isVisible"] = placeData.docs[0].get("isVisible");
    data["disLike"] = placeData.docs[0].get("disLike");
    data["like"] = placeData.docs[0].get("like");

    tempModel = PlaceModel.fromJson(data);
    tempModel.images =
        tempModel.images =
    await _filesStorageService.getImages(imageType:ImageType.placesImages.name,
        folderName: tempModel.title!);

    return tempModel;
  }
  Future<PlaceList> getPlaces() async {
    QuerySnapshot placesData =
        await _fireStore.collection(_collectionName)
            .where('isVisible', isEqualTo:true)
            .orderBy('like',descending: true).get().whenComplete(() {
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
      await _filesStorageService.getImages(imageType:ImageType.placesImages.name,
          folderName: tempModel.title!);

      placeList.places.add(tempModel);
    }
    return placeList;
  }

  Future<PlaceModel> updatePlace(
      {required PlaceModel placeModel, List<XFile>? images}) async {
    QuerySnapshot placesData = await _fireStore
        .collection(_collectionName)
        .where('id', isEqualTo: placeModel.id)
        .get();
    String placeId = placesData.docs[0].id; //id for the ref
    if(images != null) {
      placeModel.images!.addAll( await _filesStorageService.uploadImages(
          imageType: ImageType.placesImages.name,folderName: placeModel.title!, pickedImages: images!)
    );
    }
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
  // Future<PlaceModel> updatePlaceFiled(
  //     {required String id ,
  //       required String placeFieldName ,
  //       required Object placeFieldValue}) async {
  //   QuerySnapshot placesData = await _fireStore
  //       .collection(_collectionName)
  //       .where('id', isEqualTo: id)
  //       .get();
  //   String placeId = placesData.docs[0].id; //id for the ref
  //
  //   _fireStore
  //       .collection(_collectionName)
  //       .doc(placeId)
  //       .update({placeFieldName: placeFieldValue})
  //       .whenComplete(() {
  //     log("UPDATE done");
  //   }).catchError((error) {
  //     log(error.toString());
  //   });
  //   return placeModel;
  // }


}
