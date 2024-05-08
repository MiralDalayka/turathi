import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turathi/core/models/report_model.dart';

class ReportService {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "reports";


  Future<String> addReport(ReportModel model) async {
    _fireStore
        .collection(_collectionName)
        .add(model.toJson())
        .whenComplete(() => "report added successfully")
        .catchError((error) {
      log(error.toString());
      return "Failed";
    });
    return "Done";
  }

  Future<ReportModel> getReportByPlaceId(String placeId) async {
    QuerySnapshot reportData = await _fireStore
        .collection(_collectionName)
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
    QuerySnapshot reportsData =
    await _fireStore.collection(_collectionName).get().whenComplete(() {
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
}

