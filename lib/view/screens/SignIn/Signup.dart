// ignore_for_file: unused_local_variable, annotate_overrides
import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:turathi/core/controllers/signup_controller.dart';
import 'package:turathi/core/functions/get_current_location.dart';
import 'package:turathi/core/models/user_model.dart';
import 'package:turathi/core/services/firebase_auth.dart';
import 'package:turathi/core/services/user_service.dart';
import 'package:turathi/utils/Router/const_router_names.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/widgets/SignFormField.dart';
import 'package:turathi/view/widgets/deff_button%203.dart';


class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  late SignUpController signUpController;

  bool flag = false;

  @override
  void initState() {
    super.initState();
    signUpController = SignUpController();
  }

  @override
  void dispose() {
    signUpController.firstName.dispose();
    signUpController.email.dispose();
    signUpController.phone.dispose();
    signUpController.password.dispose();
    super.dispose();
  }

  GetCurrentLocation currentLocation = GetCurrentLocation();

  Widget build(BuildContext context) {
    UserService _service = UserService();
    return Scaffold(
      backgroundColor: const Color(0xffEAEBEF),
      body: SingleChildScrollView(
        child: Form(
          key: signUpController.formKey,
          child: SizedBox(
            height: LayoutManager.widthNHeight0(context, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(150.0),
                          bottomRight: Radius.circular(150.0),
                        ),
                        child: Transform.scale(
                          scale: 1.1,
                          child: Image.asset(
                            'assets/images/img_png/profile.png',
                            width: double.infinity,
                            height:
                            LayoutManager.widthNHeight0(context, 1) * 0.54,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Positioned(
                        top: LayoutManager.widthNHeight0(context, 1) * 0.155,
                        left: LayoutManager.widthNHeight0(context, 1) * 0.08,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Turathi",
                              style: TextStyle(
                                  fontSize:
                                  LayoutManager.widthNHeight0(context, 1) *
                                      0.084,
                                  color: ThemeManager.second,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: ThemeManager.fontFamily),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.18,
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormFieldWidgetSign(
                            passToggle: false,
                            passController: signUpController.firstName,
                            labelText: 'Name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Your Name must not be empty ';
                              }
                              return null;
                            },
                            str: ''),
                        SizedBox(
                          height:
                          LayoutManager.widthNHeight0(context, 1) * 0.07,
                        ),
                        TextFormFieldWidgetSign(
                            passToggle: false,
                            passController: signUpController.email,
                            labelText: 'Email Address',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email must not be empty ';
                              }
                              bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.1#$&'*+-/=?^_ {|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);
                              if (!emailValid) {
                                return "Enter valid Email";
                              }
                              return null;
                            },
                            str: ''),
                        SizedBox(
                          height:
                          LayoutManager.widthNHeight0(context, 1) * 0.07,
                        ),
                        TextFormFieldWidgetSign(
                            passToggle: false,
                            passController: signUpController.phone,
                            labelText: 'Phone',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Phone must not be empty ';
                              }
                              bool phoneExp =
                              RegExp(r'^\d{10}$').hasMatch(value);

                              if (!phoneExp) {
                                return 'Phone number is not valid ';
                              }

                              return null;
                            },
                            str: ''),
                        SizedBox(
                          height:
                          LayoutManager.widthNHeight0(context, 1) * 0.07,
                        ),
                        TextFormFieldWidgetSign(
                            passToggle: true,
                            passController: signUpController.password,
                            labelText: 'Password',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password must not be empty ';
                              }
                              if (value.length < 7) {
                                return "Password length should be more than 7 characters";
                              }
                              return null;
                            },
                            str: '')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.08,
                  ),
                  Center(
                    child: SizedBox(
                      width: LayoutManager.widthNHeight0(context, 1) * 0.55,
                      height: LayoutManager.widthNHeight0(context, 0) * 0.06,
                      child: InkWell(
                        onTap: () async {
                          if (signUpController.formKey.currentState!
                              .validate()) {
                            Position? p = await currentLocation.getCurrentLocation();
                            final user = UserModel(
                                name: signUpController.firstName.text,
                                email: signUpController.email.text,
                                pass: signUpController.password.text,
                                phone: signUpController.phone.text,
                                longitude: p?.longitude,
                                latitude: p?.latitude

                            );
                            _service.addUser(user);
                            //move 
                                   Navigator.of(context).pushReplacementNamed(signIn);
                          }
                        },
                        child: Container(
                          height: LayoutManager.widthNHeight0(context, 0) * .07,
                          decoration: BoxDecoration(
                              color: ThemeManager.primary,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: ThemeManager.second,
                                  fontSize: 20,
                                  fontFamily: ThemeManager.fontFamily,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a member?",
                        style: TextStyle(
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .width * .033,
                            fontFamily: ThemeManager.fontFamily,
                            color: Colors.grey[600]),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(signIn);
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * .033,
                                fontFamily: ThemeManager.fontFamily,
                                color: Colors.grey[700]),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



}


  // onTap: () async {
  //                         if (signUpController.formKey.currentState!
  //                             .validate()) {
  //                           Position? p = await currentLocation.getCurrentLocation();
  //                           final user = UserModel(
  //                               name: signUpController.firstName.text,
  //                               email: signUpController.email.text,
  //                               pass: signUpController.password.text,
  //                               phone: signUpController.phone.text,
  //                               longitude: p?.longitude,
  //                               latitude: p?.latitude

  //                           );
  //                           _service.addUser(user);
  //                           //move 
  //                                  Navigator.of(context).pushReplacementNamed(signIn);
  //                         }
  //                       },