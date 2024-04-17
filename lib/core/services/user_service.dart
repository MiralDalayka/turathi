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

  Future<UserList> getUsers() async {
    QuerySnapshot usersData =
        await _fireStore.collection(_collectionName).get().whenComplete(() {
      log("getPlaces done");
    }).catchError((error) {
      log(error.toString());
    });
    //map to store docs data in
    Map<String, dynamic> data = {};
    //temp model
    UserModel tempModel;
    //temp list
    UserList userList = UserList(users: []);

    for (var item in usersData.docs) {
      data["userId"] = item.get("userId");
      data["name"] = item.get("name");
      data["email"] = item.get("email");
      data["password"] = item.get("password");
      data["role"] = item.get("role");
      data["longitude"] = item.get("longitude");
      data["latitude"] = item.get("latitude");
      data["certificate"] = item.get("certificate");
      data["phone"] = item.get("phone");

      tempModel = UserModel.fromJson(data);

      userList.users.add(tempModel);
    }
    log(userList.users[0].toString());
    return userList;
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
