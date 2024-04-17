// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/controllers/login_controller.dart';
import 'package:turathi/core/controllers/signup_controller.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/widgets/custom_text_form.dart';

class PersdonalDetilsScreen extends StatefulWidget {
  const PersdonalDetilsScreen({super.key});

  @override
  State<PersdonalDetilsScreen> createState() => _PersdonalDetilsScreenState();
}

class _PersdonalDetilsScreenState extends State<PersdonalDetilsScreen> {
  SignUpController signUpController = SignUpController();
  TextController textController = TextController();
  String name = "", role = "", emailAddress = "", phoneNu = "";

  Future<String> resetEmail(String newEmail) async {
    try {
      User? firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        await firebaseUser.updateEmail(newEmail);
        return 'Success';
      } else {
        return 'User not signed in.';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }

  Future<String> resetPassword(String newPassword) async {
    try {
      User? firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        await firebaseUser.updatePassword(newPassword);
        return 'Success';
      } else {
        return 'User not signed in.';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }

  Future<void> fetchUserData() async {
    String currentEmail = FirebaseAuth.instance.currentUser?.email ?? '';

    try {
      QuerySnapshot<Object?> querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: currentEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Object?> userSnapshot = querySnapshot.docs.first;

        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          setState(() {
            name = userData['name'] ?? "";
            role = userData['role'] ?? "";
            emailAddress = userData['email'] ?? "";
            phoneNu = userData['phone'] ?? "";
          });
        } else {
          print('User data is null.');
        }
      } else {
        print('No user found with the current email.....');
      }
    } catch (error) {
      print('Error querying user document: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      fetchUserData();
    }

    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Added Places',
          style: ThemeManager.textStyle.copyWith(
            fontSize: LayoutManager.widthNHeight0(context, 1) * 0.05,
            fontWeight: FontWeight.bold,
            fontFamily: ThemeManager.fontFamily,
            color: ThemeManager.primary,
          ),
        ),
        // automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: Form(
        key: signUpController.formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Center(
              child: SizedBox(
                width: LayoutManager.widthNHeight0(context, 1) * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(height: 1, color: Colors.grey[300]),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: ThemeManager.fontFamily,
                        ),
                      ),
                    ),
                    TextFormWidgetRead(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.2,
                      width: double.infinity,
                      passToggle: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' Name must not be empty ';
                        }
                        return null;
                      },
                      passController: signUpController.firstName,
                      str: name,
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.008,
                    ),
                    Text(
                      'Role',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: ThemeManager.fontFamily,
                      ),
                    ),
                    TextFormWidgetRead(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.2,
                      width: double.infinity,
                      passToggle: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' role must not be empty ';
                        }
                        return null;
                      },
                      passController: signUpController.secondName,
                      str: role,
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.008,
                    ),
                    Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: ThemeManager.fontFamily,
                      ),
                    ),
                    TextFormWidgetRead(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.2,
                      width: double.infinity,
                      passToggle: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email must not be empty ';
                        }
                        return null;
                      },
                      passController: signUpController.email,
                      str: emailAddress,
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.008,
                    ),
                    Text(
                      'Phone',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: ThemeManager.fontFamily,
                      ),
                    ),
                    TextFormWidgetRead(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone must not be empty ';
                        }
                        return null;
                      },
                      width: double.infinity,
                      passToggle: false,
                      passController: signUpController.phone,
                      str: phoneNu,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
