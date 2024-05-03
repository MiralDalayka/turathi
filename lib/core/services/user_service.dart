import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
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

      if (await _auth.signupwithemailandpassword(
              model.email.toString(), model.password.toString()) ==
          null) {
        return "The email address is already in use by another account.";
      }
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

// //  await FirebaseAuth.instance.currentUser?.updateEmail(usershared.email);
    
//     String? email = usershared.email;

//     if (email != null) {
//       try {
//         await FirebaseAuth.instance.currentUser?.updateEmail(email);
//       } catch (error) {
//         print("Error updating email: $error");
//       }
//     } else {
//       print("Email address is null. Cannot update.");
//     }

  String? newEmail = model.email;

  if (newEmail != null) {
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(newEmail);
      print("Email updated successfully");
    } catch (error) {
      print("Error updating email: $error");
      // Handle error here
    }
  } else {
    print("New email address is null. Cannot update.");
    // Handle null email case here
  }

  // Continue with updating user data in Firestore


    QuerySnapshot userData = await _fireStore
        .collection(_collectionName)
        .where('id', isEqualTo: sharedUser.id)
        .get();

    if (userData.docs.isNotEmpty) {
      String userId = userData.docs[0].id;
      print("Hhhhhhhh ${userId}");

      _fireStore
          .collection(_collectionName)
          .doc(userId)
          .update(model.toJson())
          .whenComplete(() {
        log("user data updated successfully");
      }).catchError((error) {
        log(error.toString());
        print("object12");
      });
    } else {
      log("No user data found for the provided ID");
    }

    return model;
  }

  Future<bool> signIn(String email, String password) async {
    UserModel? userModel = await getUserByEmail(email);

    String? str = userModel!.password;

    if (str != null) if (Crypt(str).match(password)) {
      print("User is successfully in match");

      return true;
    }

    User? user = await _auth.signinwithemailandpassword(email, password);

    if (user != null) {
      print("User is successfully Signin");

      return true;
    } else {
      print("error is happend 3");
      checkUser = false;
      return false;
    }
  }

  // Future<bool> signIn(String email, String password) async {
  //
  //   User? user = await _auth.signinwithemailandpassword(
  //       email, password);
  //
  //   if (user != null) {
  //     print("User is successfully Signin");
  //     return true;
  //   } else {
  //     UserModel? userModel = await getUserByEmail(email);
  //
  //     String? str = userModel?.password;
  //     print("@@@@@@@@@@@@@@@@@$str");
  //     if (str != null) if (Crypt(str).match(password)) {
  //       print("User is successfully in match");
  //       return true;
  //     }
  //     else {
  //       print("error is happend 3");
  //       checkUser = false;
  //       return false;
  //     }
  //
  //
  //   }
  //   return false;
  // }

  signOut() async {
    sharedUser = UserModel(
        name: null,
        pass: null,
        email: null,
        phone: null,
        longitude: null,
        latitude: null);

    await auth.signOut();
    // log("testttttt ${usershared.name}");
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

    Map<String, dynamic> data =
        {}; // Retrieve data from the first document (assuming email is unique)

    data["id"] = userData.docs[0].get("id");
    data["name"] = userData.docs[0].get("name");
    data["role"] = userData.docs[0].get("role");
    data["longitude"] = userData.docs[0].get("longitude");
    data["latitude"] = userData.docs[0].get("latitude");
    data["email"] = userData.docs[0].get("email");
    data["phone"] = userData.docs[0].get("phone");
    data["password"] = userData.docs[0].get("password");
    data["favList"] = userData.docs[0].get("favList");


    return UserModel.fromJson(data);
  }

  Future<UserList> getUsers() async {
    QuerySnapshot usersData =
    await _fireStore.collection(_collectionName)
     .get().whenComplete(() {
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
      data["password"] =item.get("password");
      data["favList"] =item.get("favList");


      tempModel = UserModel.fromJson(data);
      userList.users.add(tempModel);
    }
    return userList;
  }


}
