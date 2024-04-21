import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turathi/core/models/request_model.dart';
import 'package:turathi/core/services/file_storage_service.dart';

class RequestService {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "requests";
  final FilesStorageService _filesStorageService = FilesStorageService();

  Future<String> addRequest(RequestModel model,XFile file) async {
    _fireStore.collection(_collectionName).add(model.toJson()).whenComplete(() async {
     model.certificate = await _filesStorageService.addFile(file);
     updateRequest(model);
    }).catchError((error) {
      return "Failed";
    });
    return "Done";
  }

  Future<RequestModel> getRequestById(String requestId) async{
    QuerySnapshot requestData = await _fireStore
        .collection(_collectionName)
        .where('requestId', isEqualTo: requestId)
        .get();
    Map<String, dynamic> data = {};

    RequestModel tempModel;
    data["requestId"] = requestData.docs[0].get("requestId");
    data["userId"] = requestData.docs[0].get("userId");
    data["certificate"] = requestData.docs[0].get("certificate");
    data["status"] = requestData.docs[0].get("status");

    tempModel = RequestModel.fromJson(data);

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
}
