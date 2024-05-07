import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turathi/core/models/request_model.dart';
import 'package:turathi/core/services/file_storage_service.dart';

import '../../utils/shared.dart';

class RequestService {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "requests";
  final FilesStorageService _filesStorageService = FilesStorageService();

  Future<String> addRequest(RequestModel model,File file) async {
    _fireStore.collection(_collectionName).add(model.toJson())
        .whenComplete(() async {
          log("***************REQUEST***************");
     //model.certificate = await _filesStorageService.addFile(file);
     updateRequestFiled(requestId:  model.requestId!,
         placeFieldName: "certificate",
         placeFieldValue:  await _filesStorageService.addFile(file));
    }).catchError((error) {
      return "Failed";
    });
    return "Done";
  }

  Future<RequestModel> getRequestByUserId() async{
    QuerySnapshot requestData = await _fireStore
        .collection(_collectionName)
        .where('userId', isEqualTo: sharedUser.id)
        .get();
    RequestModel tempModel=RequestModel.empty();

    if(requestData.docs.isNotEmpty) {
      Map<String, dynamic> data = {};

      data["requestId"] = requestData.docs[0].get("requestId");
      data["userId"] = requestData.docs[0].get("userId");
      data["certificate"] = requestData.docs[0].get("certificate");
      data["status"] = requestData.docs[0].get("status");

      tempModel = RequestModel.fromJson(data);
    }
    return tempModel;
  }

  Future<RequestModel> getRequestById(String requestId) async{
    QuerySnapshot requestData = await _fireStore
        .collection(_collectionName)
        .where('requestId', isEqualTo: requestId)
        .get();
    RequestModel tempModel=RequestModel.empty();

    if(requestData.docs.isNotEmpty) {
      Map<String, dynamic> data = {};

      data["requestId"] = requestData.docs[0].get("requestId");
      data["userId"] = requestData.docs[0].get("userId");
      data["certificate"] = requestData.docs[0].get("certificate");
      data["status"] = requestData.docs[0].get("status");

      tempModel = RequestModel.fromJson(data);
    }
    return tempModel;
  }

  Future<RequestModel> updateRequest(RequestModel requestModel) async {
    QuerySnapshot requestData = await _fireStore
        .collection(_collectionName)
        .where('requestId', isEqualTo: requestModel.requestId)
        .get();
    String requestId = requestData.docs[0].id;
    _fireStore
        .collection(_collectionName)
        .doc(requestId)
        .update(requestModel.toJson())
        .whenComplete(() {
      log("update done");
    }).catchError((error) {
      log(error.toString());
    });
    return requestModel;
  }

  Future<RequestModel> updateRequestFiled(
      {required String requestId ,
        required String placeFieldName ,
        required Object placeFieldValue}) async {
    QuerySnapshot placesData = await _fireStore
        .collection(_collectionName)
        .where('requestId', isEqualTo: requestId)
        .get();
    String placeId = placesData.docs[0].id; //id for the ref

    _fireStore
        .collection(_collectionName)
        .doc(placeId)
        .update({placeFieldName: placeFieldValue})
        .whenComplete(() {
      log("update ${placeFieldName} request done");
    }).catchError((error) {
      log(error.toString());
    });
    return await getRequestById(requestId);
  }
}