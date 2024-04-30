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
      print(
          "email in adduser${model.email.toString()} pass in adduser ${model.password.toString()}");

      if(await _auth.signupwithemailandpassword(model.email.toString(), model.password.toString())==null)
          {
            return "The email address is already in use by another account.";
          }
        

    } 
    catch (e) {
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

// Future<String>  signIn(String email, String password) async {
//    User? user = await _auth.signinwithemailandpassword(email, password);

//     if (user != null) {
//       print("User is successfully Signin");
//       return "Done";

//       //  Navigator.pushReplacement(
//       //     context,
//       //     MaterialPageRoute(
//       //       builder: (context) => const CustomeBottomNavBar(),
//       //     ));
//     } else {
//       print("error is happend");
//        return "error";
//     }
// }

  Future<bool> signIn(String email, String password) async {
    // UserModel userModel=UserModel(
    //                             name: signUpController.firstName.text,
    //                             email: signUpController.email.text,
    //                             pass: signUpController.password.text,
    //                             phone: signUpController.phone.text,
    //                             longitude: p?.longitude,
    //                             latitude: p?.latitude);



    User? user = await _auth.signinwithemailandpassword(email, password);

    if (user != null) {
      print("User is successfully Signin");


  


      return true;
    } else {
      print("error is happend");
      checkUser = false;
      return false;
    }
  }
  // print("Email: $email, Password: $password");
  // try {
  //   await _auth.signinwithemailandpassword(email, password);
  //   print("SIGN IN DONE");

  // } catch (e) {
  //   print("Error occurred: $e");
  //   return "An error occurred during sign in";
  // }

  // //here to retrieve the user info based on email
  // user = await getUserByEmail(email);
  // return "Sign in successful";

  signOut() async {
    await auth.signOut();
  }

  Future<UserModel> getUserByEmail(String email) async {
    QuerySnapshot userData = await _fireStore
        .collection(_collectionName)
        .where('email', isEqualTo: email)
        .get();
    Map<String, dynamic> data = {};

    UserModel tempModel;
    data["id"] = userData.docs[0].get("id");
    data["name"] = userData.docs[0].get("name");
    data["role"] = userData.docs[0].get("role");
    data["longitude"] = userData.docs[0].get("longitude");
    data["latitude"] = userData.docs[0].get("latitude");
    data["email"] = userData.docs[0].get("email");
    data["phone"] = userData.docs[0].get("phone");

    tempModel = UserModel.fromJson(data);

    return tempModel;
  }

  
}
