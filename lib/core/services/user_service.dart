import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:turathi/core/models/user_model.dart';

import '../../utils/shared.dart';
import 'firebase_auth.dart';

class UserService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuthService _auth = FirebaseAuthService();
    FirebaseAuth auth = FirebaseAuth.instance;

  final String _collectionName = "users";
  Future<String> addUser(UserModel model) async {
    bool mounted = false;
    try {
      await _auth.signupwithemailandpassword(
          model.email.toString(), model.password.toString());
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

  Future<String> signIn(String email, String pass) async {
    bool mounted = false;
    try {
      await _auth.signinwithemailandpassword(email, pass).whenComplete(() => log("SIGN IN DONE"));
    } catch (e) {
      if (e is FirebaseAuthException) {
        log("Error occurred: $e");
        mounted = true;
        String errorMessage = "An error occurred during sign in";
        if (mounted) {
          return errorMessage;
        }
      }
    }
    QuerySnapshot placeData = await _fireStore
        .collection(_collectionName)
        .where('email', isEqualTo: email)
        .get();
    Map<String, dynamic> data = {};

    UserModel tempModel;
      data["name"] = placeData.docs[0].get("name");
      // data["email"] = placeData.docs[0].get("email");
      tempModel = UserModel.fromJson(data);
    user = tempModel;


    return "*********";

    } 
    
    signOut() async {
    await auth.signOut();
  }
    


  }

