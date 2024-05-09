import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:turathi/core/models/admin_model.dart';
import 'package:turathi/core/models/notification_model.dart';
import 'package:turathi/core/models/report_model.dart';
import 'package:turathi/core/models/request_model.dart';
import 'package:turathi/core/models/user_model.dart';
import 'package:turathi/core/services/file_storage_service.dart';

class AdminService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "admins";
  final String _reportCollectionName = "reports";
  final String _requestCollectionName = "requests";
  final String _placeCollectionName = "places";
  final String _userCollectionName = "users";
  final FilesStorageService _filesStorageService = FilesStorageService();

  Future<bool> signIn(String adminId, String password) async {
    AdminModel? adminModel = await _getAdmin(adminId);

    if (adminModel != null && adminModel.password != null) {
      String? passwordFromDb = adminModel.password;

      if (Crypt(passwordFromDb!).match(password)) {
        return true;
      }
    }
    return false;
  }

  Future<ReportModel> getReportByPlaceId(String placeId) async {
    QuerySnapshot reportData = await _fireStore
        .collection(_reportCollectionName)
        .where('placeId', isEqualTo: placeId)
        .get();
    ReportModel tempModel = ReportModel.empty();

    if (reportData.docs.isNotEmpty) {
      Map<String, dynamic> data = {};

      data["reportId"] = reportData.docs[0].get("reportId");
      data["reasons"] = reportData.docs[0].get("reasons");
      data["userId"] = reportData.docs[0].get("userId");
      data["placeId"] = reportData.docs[0].get("placeId");

      tempModel = ReportModel.fromJson(data);
    }
    return tempModel;
  }

  Future<ReportList> getReports() async {
    QuerySnapshot reportsData = await _fireStore
        .collection(_reportCollectionName)
        .get()
        .whenComplete(() {
      log("get reports done");
    }).catchError((error) {
      log(error.toString());
    });
    Map<String, dynamic> data = {};
    ReportModel tempModel;
    ReportList reportList = ReportList(reports: []);
    for (var item in reportsData.docs) {
      data["reportId"] = item.get("reportId");
      data["reasons"] = item.get("reasons");
      data["userId"] = item.get("userId");
      data["placeId"] = item.get("placeId");

      tempModel = ReportModel.fromJson(data);

      reportList.reports.add(tempModel);
    }
    return reportList;
  }

  Future<RequestList> getRequests() async {
    QuerySnapshot requestsData = await _fireStore
        .collection(_requestCollectionName)
        .get()
        .whenComplete(() {
      log("get requests done");
    }).catchError((error) {
      log(error.toString());
    });
    Map<String, dynamic> data = {};
    RequestModel tempModel;
    RequestList requestList = RequestList(requests: []);
    for (var item in requestsData.docs) {
      data["requestId"] = item.get("requestId");
      data["status"] = item.get("status");
      data["certificate"] = item.get("certificate");
      data["userId"] = item.get("userId");
      tempModel = RequestModel.fromJson(data);
      requestList.requests.add(tempModel);
    }
    return requestList;
  }

  Future<void> updateRequestStatus(
      {required RequestModel requestModel, required RequestStatus requestStatus}) async {
    QuerySnapshot requestData = await _fireStore
        .collection(_requestCollectionName)
        .where('requestId', isEqualTo: requestModel.requestId)
        .get();
    String id = requestData.docs[0].id;
    _fireStore
        .collection(_requestCollectionName)
        .doc(id)
        .update({'status': requestStatus.name}).whenComplete(() {
          if(requestStatus.name == RequestStatus.accepted.name){
            updateUserRoleToExpert(id: requestModel.userId!);
          }
          else  if(requestStatus.name == RequestStatus.rejected.name){
            deleteRequest(requestModel: requestModel);
          }
          else {
            notifyUser(requestModel.userId!, "your request status is ${requestStatus.name}");

          }
      log("update request status done");
    }).catchError((error) {
      log(error.toString());
    });
  }
  Future<void> deleteRequest(
      {required RequestModel requestModel}) async {
    QuerySnapshot requestData = await _fireStore
        .collection(_requestCollectionName)
        .where('requestId', isEqualTo: requestModel.requestId)
        .get();
    String id = requestData.docs[0].id;
    _fireStore
        .collection(_requestCollectionName)
        .doc(id)
        .delete().whenComplete(() {
          _filesStorageService.deleteFile(userId: requestModel.userId!);
      notifyUser(requestModel.userId!, "your request to be expert is rejected");
      log("delete request done");
    }).catchError((error) {
      log(error.toString());
    });
  }

  Future<void> updateUserRoleToExpert({required String id}) async {
    QuerySnapshot requestData = await _fireStore
        .collection(_userCollectionName)
        .where('id', isEqualTo: id)
        .get();
    String userId = requestData.docs[0].id;
    _fireStore
        .collection(_userCollectionName)
        .doc(userId)
        .update({'role': UsersRole.expert.name}).whenComplete(() {
      notifyUser(userId, "your role is expert");
      log("update user role done");
    }).catchError((error) {
      log(error.toString());
    });
  }

  Future<void> updatePlaceVisibility(
      {required String id, required bool isVisible}) async {
    QuerySnapshot placesData = await _fireStore
        .collection(_placeCollectionName)
        .where('placeId', isEqualTo: id)
        .get();
    String placeId = placesData.docs[0].id; //id for the ref

    _fireStore
        .collection(_placeCollectionName)
        .doc(placeId)
        .update({"isVisible": isVisible}).whenComplete(() {
      log("update isVisible to ${isVisible.toString()} done");
    }).catchError((error) {
      log(error.toString());
    });
  }

  Future<void> notifyUser(String userId, String text) async {
    NotificationModel notificationModel =
        NotificationModel(userId: userId, text: text);
    _fireStore
        .collection("notifications")
        .add(notificationModel.toJson())
        .whenComplete(() {
      log("Add Notification to ${userId} Done");
    });
  }

  Future<AdminModel?> _getAdmin(String adminId) async {
    QuerySnapshot adminData = await _fireStore
        .collection(_collectionName)
        .where('adminId', isEqualTo: adminId)
        .get();
    if (adminData.docs.isEmpty) {
      return null;
    }

    Map<String, dynamic> data = {};
    data["adminId"] = adminData.docs[0].get("adminId");
    data["password"] = adminData.docs[0].get("password");
    return AdminModel.fromJson(data);
  }
}
