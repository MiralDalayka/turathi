import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:turathi/core/models/user_model.dart';

import 'firebase_auth.dart';

class UserService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuthService _auth = FirebaseAuthService();

  final String _collectionName = "users";

  Future<String> addUser(UserModel model) async {
    bool mounted = false;
    try {
      /////////////////////////////////newwww
      await _auth.signupwithemailandpassword(
          model.email.toString(), model.password.toString());
    } catch (e) {
      if (e is FirebaseAuthException) {
        log("Error occurred: $e");
        mounted=true;
        String errorMessage = "An error occurred during sign up.";

        if (e.code == 'email-already-in-use') {
          errorMessage = "The account already exists for that email.";
        }
        if (mounted) {
          return errorMessage;
        }
      }
    }

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

  // Future<UserList> getUsers() async {
  //   QuerySnapshot usersData =
  //       await _fireStore.collection(_collectionName).get().whenComplete(() {
  //     log("getPlaces done");
  //   }).catchError((error) {
  //     log(error.toString());
  //   });
  //   //map to store docs data in
  //   Map<String, dynamic> data = {};
  //   //temp model
  //   UserModel tempModel;
  //   //temp list
  //   UserList userList = UserList(users: []);
  //
  //   for (var item in usersData.docs) {
  //     data["id"] = item.get("id");
  //     data["name"] = item.get("name");
  //     data["email"] = item.get("email");
  //     data["password"] = item.get("password");
  //     data["role"] = item.get("role");
  //     data["longitude"] = item.get("longitude");
  //     data["latitude"] = item.get("latitude");
  //     data["certificate"] = item.get("certificate");
  //     data["phone"] = item.get("phone");
  //
  //     tempModel = UserModel.fromJson(data);
  //
  //     userList.users.add(tempModel);
  //   }
  //   log(userList.users[0].toString());
  //   return userList;
  // }

  Future<UserModel> updateUser(UserModel model) async {
    QuerySnapshot userData = await _fireStore
        .collection(_collectionName)
        .where('id', isEqualTo: model.id)
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

  //get user name after sign up
}
