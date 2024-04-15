import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turathi/core/models/user_model.dart';


class UserService {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "users";


  Future<String> addUser(UserModel model) async {
    _fireStore
        .collection(_collectionName)
        .add(model.toJson())
        .whenComplete(() => "user added successfully")
        .catchError((error) {
      log(error.toString());
      return "Failed";
    });
    return "Done";
  }


  Future<UserModel> updateUser(UserModel model) async {
    QuerySnapshot userData = await _fireStore
        .collection(_collectionName)
        .where('userId', isEqualTo: model.userId)
        .get();
    String userId = userData.docs[0].id;
    _fireStore
        .collection(_collectionName)
        .doc(userId)
        .update(model.toJson())
        .whenComplete(() {
      log("user data updated successfully");
    }).catchError((error) {
      log(error.toString());
    });
    return model;
  }
}

