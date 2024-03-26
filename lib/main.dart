import 'package:flutter/material.dart';
import 'package:turathi/core/models/question_model.dart';
import 'package:turathi/utils/Router/const_router_names.dart';
import 'package:turathi/utils/Router/router_class.dart';
import 'package:turathi/view/screens/community_screens/community_screen.dart';
import 'package:turathi/view/screens/community_screens/question_view.dart';
import 'package:turathi/view/screens/favorite_screens/favorite_screen.dart';
import 'package:turathi/view/screens/home_screen_widgets/home_screen.dart';
import 'package:turathi/view/screens/location_screens/location_Screen.dart';
import 'package:turathi/view/screens/profile_screens/profile.dart';
import 'package:turathi/view/screens/profile_screens/screens/added_places.dart';
import 'package:turathi/view/screens/splach_screen/splach_screen.dart';
import 'package:turathi/view/widgets/custom_bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      onGenerateRoute: MyRouter.generateRoute,
      initialRoute: initRoute,
        // home: const SplashScreen(),
        // routes: {
        //   "bottomScreen": (context) => const CustomeBottomNavBar(),
        //   "homeScreen": (context) => const HomeScreen(),
        //   "profileScreen": (context) => const ProfileScreen(),
        //   "communityScreen": (context) => const CommunityScreen(),
        //   "favoriteScreen": (context) => const FavoriteScreen(),
        //   "locationPage": (context) => const LocationPage(),
        //   "addedCard": (context) => const AddedPlaces(),
        //
        //
        // },
        // onGenerateRoute: (settings) {
        //   if (settings.name == 'questionView') {
        //     final QuestionModel question = settings.arguments as QuestionModel;
        //     return MaterialPageRoute(
        //       builder: (context) => QuestionView(question: question),
        //     );
        //   }
        // }


        );
  }
}
