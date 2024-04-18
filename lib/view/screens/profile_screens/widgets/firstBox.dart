import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/services/user_service.dart';
import 'package:turathi/utils/Router/const_router_names.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/SignIn/signin.dart';

class firstBox extends StatefulWidget {
  const firstBox({super.key});

  @override
  State<firstBox> createState() => FirstBox();
}

class FirstBox extends State<firstBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: ThemeManager.second,
      ),
      child: Container(
          height: LayoutManager.widthNHeight0(context, 1) * 0.5,
          padding:
              EdgeInsets.all(LayoutManager.widthNHeight0(context, 1) * 0.05),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  final currentUser = UserService().auth.currentUser;
                  if (currentUser != null && currentUser.isAnonymous) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: ThemeManager.primary,
                          content: Text(
                            'You Have To Sign In First \nTo See Your Personal Details!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    LayoutManager.widthNHeight0(context, 1) *
                                        0.035,
                                fontFamily: ThemeManager.fontFamily),
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    UserService().signOut();
                                    log("sign out");

                                    Navigator.of(context).pushNamed(signIn);
                                  },
                                  child: Text(
                                    'SignIn',
                                    style: TextStyle(
                                      fontFamily: ThemeManager.fontFamily,
                                      color: Colors.white,
                                      fontSize: LayoutManager.widthNHeight0(
                                              context, 1) *
                                          0.035,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    log("&&&&&&&&&&&&&");
                    Navigator.of(context).pushNamed(personalDetilsScreen);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/img_png/userProfile.png',
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.03,
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.06,
                          ),
                          SizedBox(
                              width: LayoutManager.widthNHeight0(context, 0) *
                                  0.015),
                          Text(
                            'Personal details',
                            style: TextStyle(
                                fontSize:
                                    LayoutManager.widthNHeight0(context, 1) *
                                        0.038,
                                fontFamily: 'KohSantepheap',
                                color: ThemeManager.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // InkWell(
              //   onTap: () {
              //      // Navigator.of(context).pushNamed(personalDetilsScreen);
              //   },
              //   child: Padding(
              //     padding: EdgeInsets.only(right: 17),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             Image.asset(
              //               'assets/images/img_png/userProfile.png',
              //               width:  LayoutManager.widthNHeight0(context, 0) *
              //                     0.03,
              //               height: LayoutManager.widthNHeight0(context, 1) *
              //                     0.06,
              //             ),
              //             SizedBox(
              //                 width: LayoutManager.widthNHeight0(context, 0) *
              //                     0.015),
              //             Text(
              //               'Personal details',
              //               style: TextStyle(
              //                   fontSize:
              //                       LayoutManager.widthNHeight0(context, 1) *
              //                           0.038,
              //                   fontFamily: 'KohSantepheap',
              //                   color: ThemeManager.primary,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              SizedBox(
                height: LayoutManager.widthNHeight0(context, 1) * 0.05,
              ),

              InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed("Change Info");
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/img_png/infoProfile.png',
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.03,
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.06,
                          ),
                          SizedBox(
                              width: LayoutManager.widthNHeight0(context, 0) *
                                  0.015),
                          Text(
                            'Change Info',
                            style: TextStyle(
                                fontSize:
                                    LayoutManager.widthNHeight0(context, 1) *
                                        0.038,
                                fontFamily: 'KohSantepheap',
                                color: ThemeManager.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 1) * 0.05,
              ),

              InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed("Change Password");
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/img_png/lockProfile.png',
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.03,
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.06,
                          ),
                          SizedBox(
                              width: LayoutManager.widthNHeight0(context, 0) *
                                  0.015),
                          Text(
                            'Change Password',
                            style: TextStyle(
                                fontSize:
                                    LayoutManager.widthNHeight0(context, 1) *
                                        0.038,
                                fontFamily: 'KohSantepheap',
                                color: ThemeManager.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 1) * 0.05,
              ),
              /////
              InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed("Delete Account");
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/img_png/deleteProfile.png',
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.03,
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.055,
                          ),
                          SizedBox(
                              width: LayoutManager.widthNHeight0(context, 0) *
                                  0.015),
                          Text(
                            'Delete Account',
                            style: TextStyle(
                                fontSize:
                                    LayoutManager.widthNHeight0(context, 1) *
                                        0.038,
                                fontFamily: 'KohSantepheap',
                                color: ThemeManager.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
