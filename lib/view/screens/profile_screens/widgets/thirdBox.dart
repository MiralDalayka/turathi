import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/services/user_service.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/lib_organizer.dart';
import 'package:turathi/utils/theme_manager.dart';

import '../../../../core/models/comment_model.dart';
import '../../../../core/services/comment_service.dart';

class thirdBox extends StatefulWidget {
  const thirdBox({super.key});

  @override
  State<thirdBox> createState() => _thirdBox();
}

class _thirdBox extends State<thirdBox> {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    // CommentService commentService=CommentService();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: const Color(0xffF7F3EE),
      ),
      child: Container(
          height: LayoutManager.widthNHeight0(context, 1) * 0.3,
          padding:
              EdgeInsets.all(LayoutManager.widthNHeight0(context, 1) * 0.05),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(aboutUsScreen);
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
                                LayoutManager.widthNHeight0(context, 1) * 0.054,
                          ),
                          SizedBox(
                              width: LayoutManager.widthNHeight0(context, 0) *
                                  0.015),
                          Text(
                            'About us',
                            style: TextStyle(
                                fontSize:
                                    LayoutManager.widthNHeight0(context, 1) *
                                        0.038,
                                fontFamily: ThemeManager.fontFamily,
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
                  // Navigator.of(context).pushNamed(sginout);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: GestureDetector(
                    onTap: () async {
                      userService.signOut();

                      print("sign out");

                      Navigator.of(context).pushReplacementNamed(signIn);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.login_outlined,
                          size: LayoutManager.widthNHeight0(context, 1) * 0.045,
                          color: Color(0xff263238),
                        ),
                        SizedBox(
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.02),
                        Text(
                          'Sign out',
                          style: TextStyle(
                              fontSize:
                                  LayoutManager.widthNHeight0(context, 1) *
                                      0.038,
                              color: ThemeManager.primary,
                              fontFamily: ThemeManager.fontFamily,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
