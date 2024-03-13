import 'package:flutter/material.dart';
import 'package:turathi/core/models/question_model.dart';
import 'package:turathi/view/screens/community_screens/community_screen.dart';
import 'package:turathi/view/screens/community_screens/question_view.dart';
import 'package:turathi/view/screens/home_screen.dart';
import 'package:turathi/view/screens/profile/profile.dart';
import 'package:turathi/view/screens/splach_screen/splachScreen.dart';
import 'package:turathi/view/widgets/custom_bottom_nav_bar.dart';
import 'package:turathi/view/screens/community_screens/widgets/question_box.dart';

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

        home: SplashScreen(),
        routes: {
          "bottomScreen": (context) => const CustomeBottomNavBar(),
          "homeScreen": (context) => const HomeScreen(),
          "profileScreen": (context) => const ProfileScreen(),
          "communityScreen": (context) => const CommunityScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == 'questionView') {
            final QuestionModel question = settings.arguments as QuestionModel;
            return MaterialPageRoute(
              builder: (context) => QuestionView(question: question),
            );
          }
        });
  }
}
