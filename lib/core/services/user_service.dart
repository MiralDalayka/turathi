import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turathi/core/functions/get_current_location.dart';
import 'package:turathi/core/models/user_model.dart';
import '../../utils/shared.dart';

class UserService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "users";

  Future<String> addUser(UserModel model, String password) async {
    bool mounted = false;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: model.email!, password: password);
    } catch (e) {
      if (e is FirebaseAuthException) {
        log("Error occurred: $e");
        mounted = true;
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

  Future<UserModel> updateUser(String id) async {
    String? newEmail = sharedUser.email;

    if (newEmail != null) {
      try {
        var currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser?.email != newEmail) {
          await currentUser?.updateEmail(newEmail);
          print("Email updated successfully");
        } else {
          print("Email is already up-to-date");
        }
      } catch (error) {
        print("Error updating email: $error");
      }
    } else {
      print("New email address is null. Cannot update.");
    }
///////here update the user info in the firestore
    QuerySnapshot userData = await _fireStore
        .collection(_collectionName)
        .where('id', isEqualTo: id)
        .get();
    String userId = userData.docs[0].id;

    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update(
        {
          'name': sharedUser.name,
          'email': sharedUser.email,
          'phone': sharedUser.phone,
        },
      ).whenComplete(() {
        log("user update : ${userId}");
      });
    } on FirebaseException catch (e) {
      log(e.toString());
    }
    return await getUserById(id);
  }

  Future<void> updateUserLocation() async {
    QuerySnapshot userData = await _fireStore
        .collection(_collectionName)
        .where('id', isEqualTo: sharedUser.id)
        .get();
    String userId = userData.docs[0].id;
    GetCurrentLocation getCurrentLocation = GetCurrentLocation();
    Position? currentLocation = await getCurrentLocation.getCurrentLocation();
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update(
        {
          'latitude': currentLocation!.latitude,
          'longitude': currentLocation.longitude,
        },
      ).whenComplete(() {
        log("user current location updated successfully");
        sharedUser.latitude = currentLocation.latitude;
        sharedUser.longitude= currentLocation.longitude;
      });
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      sharedUser = (await getUserByEmail(email))!;
      log(credential.user.toString());
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      return false;
    } catch (e) {
      rethrow;
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<UserModel?> getUserByEmail(String email) async {
    QuerySnapshot userData = await _fireStore
        .collection(_collectionName)
        .where('email', isEqualTo: email)
        .get();

    if (userData.docs.isEmpty) {
      // Email not found in the DB

      return null;
    }

    Map<String, dynamic> data = {}; // Retrieve data from the first document

    data["id"] = userData.docs[0].get("id");
    data["name"] = userData.docs[0].get("name");
    data["role"] = userData.docs[0].get("role");
    data["longitude"] = userData.docs[0].get("longitude");
    data["latitude"] = userData.docs[0].get("latitude");
    data["email"] = userData.docs[0].get("email");
    data["phone"] = userData.docs[0].get("phone");
    data["favList"] = userData.docs[0].get("favList");

    return UserModel.fromJson(data);
  }

  Future<UserList> getUsers() async {
    QuerySnapshot usersData =
        await _fireStore.collection(_collectionName).get().whenComplete(() {
      log("get users done");
    }).catchError((error) {
      log(error.toString());
    });
    Map<String, dynamic> data = {};
    UserModel tempModel;
    UserList userList = UserList(users: []);
    for (var item in usersData.docs) {
      data["id"] = item.get("id");
      data["name"] = item.get("name");
      data["role"] = item.get("role");
      data["longitude"] = item.get("longitude");
      data["latitude"] = item.get("latitude");
      data["email"] = item.get("email");
      data["phone"] = item.get("phone");
      data["favList"] = item.get("favList");

      tempModel = UserModel.fromJson(data);
      userList.users.add(tempModel);
    }
    return userList;
  }

  Future<void> favPlace(String id) async {
    try {
      QuerySnapshot userData = await _fireStore
          .collection(_collectionName)
          .where('id', isEqualTo: sharedUser.id)
          .get();
      String userId = userData.docs[0].id;

      await FirebaseFirestore.instance.collection('users').doc(userId).update(
        {
          'favList': FieldValue.arrayUnion([id]),
        },
      ).whenComplete(() {
        log("fav place  added : $id");
      });
    } on FirebaseException catch (e) {
      log(e.toString() + "&");
    }
  }

  Future<void> removeFavPlace(String id) async {
    try {
      QuerySnapshot userData = await _fireStore
          .collection(_collectionName)
          .where('id', isEqualTo: sharedUser.id)
          .get();
      String userId = userData.docs[0].id;
      await FirebaseFirestore.instance.collection('users').doc(userId).update(
        {
          'favList': FieldValue.arrayRemove([id]),
        },
      ).whenComplete(() {
        log("fav place   remove : $id");
      });
    } on FirebaseException catch (e) {
      log(e.toString() + "^");
    }
  }

  Future<void> deleteUser() async {
    //delete from Auth
    try {
      print("object${FirebaseAuth.instance.currentUser?.uid}");
      print("qqqqqq->${FirebaseAuth.instance.currentUser!}");
      await FirebaseAuth.instance.currentUser!.delete();

      //  print("FirebaseAuth.instance.currentUser${FirebaseAuth.instance.currentUser?.email}");

      print('Successfully deleted user');
    } catch (error) {
      print('Error deleting user 1: $error');
    }

    //here delete from the firestore
    var db = FirebaseFirestore.instance;
    var usersRef = db.collection('users');

    usersRef.where('id', isEqualTo: sharedUser.id).get().then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        var docId = doc.id;
        print("Document ID for current user: $docId");

        print("Done user: $docId");
        doc.reference.delete().then((_) {
          print('Successfully deleted document');
        }).catchError((error) {
          print('Error deleting user: $error');
        });
      } else {
        print("No documents found for current user.");
      }
    }).catchError((error) {
      print("Error getting documents: $error");
    });
  }

  Future<UserModel> getUserById(String Id) async {
    QuerySnapshot userData = await _fireStore
        .collection(_collectionName)
        .where('id', isEqualTo: Id)
        .get();
    Map<String, dynamic> data = {};

    UserModel tempModel;
    data["id"] = userData.docs[0].get("id");
    data["name"] = userData.docs[0].get("name");
    data["role"] = userData.docs[0].get("role");
    data["longitude"] = userData.docs[0].get("longitude");
    data["latitude"] = userData.docs[0].get("latitude");
    data["phone"] = userData.docs[0].get("phone");
    data["email"] = userData.docs[0].get("email");
    data["favList"] = userData.docs[0].get("favList");

    tempModel = UserModel.fromJson(data);

    return tempModel;
  }
}
