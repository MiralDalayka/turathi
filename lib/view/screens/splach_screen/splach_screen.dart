import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/services/user_service.dart';
import 'package:turathi/utils/shared.dart';
import '../../../utils/Router/const_router_names.dart';
import '../../../utils/layout_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserService userService = UserService();
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () async {
        if (FirebaseAuth.instance.currentUser == null) {
          log("&&&");
       
          Navigator.of(context).pushReplacementNamed(signIn);
        } else {
        
          sharedUser =  (await userService.getUserByEmail(FirebaseAuth.instance.currentUser!.email!))!;
             print(FirebaseAuth.instance.currentUser);
          Navigator.of(context).pushReplacementNamed(bottomNavRoute);
          
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: LayoutManager.widthNHeight0(context, 0),
        width: LayoutManager.widthNHeight0(context, 1),
        child: Image.asset(
          'assets/images/img_png/splach.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
