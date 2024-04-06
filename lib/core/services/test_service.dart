import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:turathi/core/models/testModel.dart';

class TestService {
  //create instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String collectionName = "places";

  //add -get - update visibility,modify info

  Future<String> addTest(TestModel model) async {
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

  Future<TestList> getTests() async {
    QuerySnapshot testsData =
        await _fireStore.collection(collectionName).get().whenComplete(() {
      log("getTests done");
    }).catchError((error) {
      log(error.toString());
    });
    //map to store docs data in
    Map<String, dynamic> data = {};
    //temp model
    TestModel tempModel;
    //temp list
    TestList testList = TestList(tests: []);
    for (var item in testsData.docs) {
      data["title"] = item.get("title");
      data["num"] = item.get("num");

      tempModel = TestModel.fromJson(data);
      testList.tests.add(tempModel);
    }

    return testList;
  }

 Future<TestModel> updateTest(TestModel testModel) async {
    QuerySnapshot testData = await _fireStore
        .collection(collectionName)
        .where('num', isEqualTo: testModel.num)
        .get();
    String testsId = testData.docs[0].id; //id for the ref
    _fireStore
        .collection(collectionName)
        .doc(testsId)
        .update(testModel.toJson())
        .whenComplete(() {
      log("UPDATE done");
    }).catchError((error) {
      log(error.toString());
    });
    return testModel;
  }
}

