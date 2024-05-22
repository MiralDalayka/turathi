import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turathi/core/models/report_model.dart';

class ReportService {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "reports";


  // add report about place to database
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

}

