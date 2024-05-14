import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/core/services/file_storage_service.dart';
import 'package:turathi/core/services/notification_service.dart';

import '../../utils/shared.dart';

class PlaceService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "places";
  final FilesStorageService _filesStorageService = FilesStorageService();
  final NotificationService _notificationService = NotificationService();
  Future<PlaceModel> addPlace(
      {required PlaceModel model, required List<XFile> images}) async {
    model.images = await _filesStorageService
        .uploadImages(
            imageType: ImageType.placesImages.name,
            folderName: model.placeId!,
            pickedImages: images!)
        .whenComplete(() {
      _fireStore
          .collection(_collectionName)
          .add(model.toJson())
          .whenComplete(() {
        _notificationService.notifyUsers(model.latitude!, model.longitude!);

        /////
        log("Add Place Done");
      });
    });

    return model;
  }

  Future<PlaceList> getPlaces() async {
    QuerySnapshot placesData = await _fireStore
        .collection(_collectionName)
        .where('isVisible', isEqualTo: true)
        .orderBy('like', descending: true)
        .get()
        .whenComplete(() {
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
      data["placeId"] = item.get("placeId");
      data["userId"] = item.get("userId");
      data["state"] = item.get("state");
      data["address"] = item.get("address");
      data["status"] = item.get("status");
      data["description"] = item.get("description");
      data["title"] = item.get("title");
      data["latitude"] = item.get("latitude");
      data["longitude"] = item.get("longitude");
      data["isVisible"] = item.get("isVisible");
      data["like"] = item.get("like");
      data["likesList"] =  item.get("likesList");
      tempModel = PlaceModel.fromJson(data);
      tempModel.images = await _filesStorageService.getImages(
          imageType: ImageType.placesImages.name, folderName: tempModel.placeId!);

      placeList.places.add(tempModel);
    }
    return placeList;
  }

  Future<PlaceModel> updatePlace(
      {required PlaceModel placeModel, List<XFile>? images}) async {
    QuerySnapshot placesData = await _fireStore
        .collection(_collectionName)
        .where('placeId', isEqualTo: placeModel.placeId)
        .get();
    String placeId = placesData.docs[0].id; //id for the ref
    log(images.toString());
    if (images != null) {
      placeModel.images!.addAll(await _filesStorageService.uploadImages(
          imageType: ImageType.placesImages.name,
          folderName: placeModel.placeId!,
          pickedImages: images!));
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

  Future<PlaceModel> getPlaceById(String id) async {
    QuerySnapshot placeData = await _fireStore
        .collection(_collectionName)
        .where('placeId', isEqualTo: id)
        .get();
    Map<String, dynamic> data = {};

    PlaceModel tempModel;
    data["placeId"] = placeData.docs[0].get("placeId");
    data["userId"] = placeData.docs[0].get("userId");
    data["state"] = placeData.docs[0].get("state");
    data["address"] = placeData.docs[0].get("address");
    data["status"] = placeData.docs[0].get("status");
    data["description"] = placeData.docs[0].get("description");
    data["title"] = placeData.docs[0].get("title");
    data["latitude"] = placeData.docs[0].get("latitude");
    data["longitude"] = placeData.docs[0].get("longitude");
    data["isVisible"] = placeData.docs[0].get("isVisible");
    data["like"] = placeData.docs[0].get("like");
    data["likesList"] = placeData.docs[0].get("likesList");

    tempModel = PlaceModel.fromJson(data);
    tempModel.images = tempModel.images = await _filesStorageService.getImages(
        imageType: ImageType.placesImages.name, folderName: tempModel.placeId!);

    return tempModel;
  }
  Future<PlaceModel> likePlace(String id) async {
    QuerySnapshot placesData = await _fireStore
        .collection(_collectionName)
        .where('placeId', isEqualTo: id)
        .get();
    String placeId = placesData.docs[0].id;

    try {
      await FirebaseFirestore.instance.collection('places').doc(placeId).update(
        {
          'likesList': FieldValue.arrayUnion([sharedUser.id]),
          'like': FieldValue.increment(1),
          if (placesData.docs[0].get("like") >= 5)
            'state': PlaceState.TrustWorthy.name

        },
      ).whenComplete(() {
        log("LIKE POST : ${placeId}");

      });
    } on FirebaseException catch (e) {
      log(e.toString());
    }
    return await getPlaceById( id);
  }



}
