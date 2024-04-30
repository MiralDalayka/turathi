import 'dart:async';
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
  late FirebaseAuth auth; 
   UserService userService=UserService();

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance; 


    Timer(
      const Duration(seconds: 3),
      () async {
        User? currentUser = auth.currentUser;
        // print(currentUser?.email);
     String? emmail=currentUser?.email;
     if(emmail!=null){
    if(currentUser?.displayName==null){
      usershared = await userService.getUserByEmail(
                                     emmail );
    }
     }

        if (currentUser != null && !currentUser.isAnonymous) {

          currentUser.reload().then((_) {

            if (FirebaseAuth.instance.currentUser != null) {
              Navigator.of(context).pushReplacementNamed(bottomNavRoute);
            } 
            
           
          });
        } 
        else {
          Navigator.of(context).pushReplacementNamed(signIn);
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
