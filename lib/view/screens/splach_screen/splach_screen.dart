import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/Router/const_router_names.dart';
import '../../../utils/layout_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => (FirebaseAuth.instance.currentUser != null)
            ? Navigator.of(context).pushReplacementNamed(bottomNavRoute)
            : Navigator.of(context).pushReplacementNamed(signIn));
    super.initState();
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
