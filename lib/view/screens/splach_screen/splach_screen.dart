import 'dart:async';
import 'package:flutter/material.dart';

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
        //  (FirebaseAuth.instance.currentUser != null)
        // ?
        () => Navigator.of(context).pushReplacementNamed("bottomScreen")

        // : Navigator.of(context).pushReplacementNamed("signin")

        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.asset(
          'assets/images/img_png/splach.png',
         
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
