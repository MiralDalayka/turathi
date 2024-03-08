import 'package:flutter/material.dart';
import 'package:turathi/view/screens/homeScreen.dart';
import 'package:turathi/view/screens/profile/profile.dart';
import 'package:turathi/view/screens/splach_screen/splachScreen.dart';
import 'package:turathi/view/widgets/customBottomNavBar.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
         "bottomScreen": (context) => const CustomeBottomNavBar(),
        "homeScreen": (context) => const HomeScreen(),
        "profileScreen": (context) => const ProfileScreen(),
      },
    );
  }
}

