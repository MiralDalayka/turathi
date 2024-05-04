import 'package:flutter/material.dart';
import 'package:turathi/core/functions/dialog_signin.dart';
import 'package:turathi/core/services/user_service.dart';
import 'package:turathi/utils/Router/const_router_names.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';

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
                      builder: (BuildContext context) => showCustomAlertDialog(
                          context,
                          "You Have To SignIn First \nTo See Your Personal Details!"),
                    );
                    
                  } else {
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
                  final currentUser = UserService().auth.currentUser;
                  if (currentUser != null && currentUser.isAnonymous) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => showCustomAlertDialog(
                          context,
                          "You Have To SignIn First \nTo See Your Personal Details!"),
                    );
                    
                  } else {
                    Navigator.of(context).pushNamed(changeInfo);
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
              /////
              InkWell(
                onTap: () {
       
                  final currentUser = UserService().auth.currentUser;
                  if (currentUser != null && currentUser.isAnonymous) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => showCustomAlertDialog(
                          context,
                          "You Have To SignIn First \nTo See Your Personal Details!"),
                    );
                    
                  } else {
                    Navigator.of(context).pushNamed(deleteuserpage);
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
            ],
          )),
    );
  }
}
