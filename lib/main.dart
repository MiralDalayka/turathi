import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/providers/comment_provider.dart';
import 'package:turathi/core/providers/event_provider.dart';
import 'package:turathi/core/providers/notification_provider.dart';
import 'package:turathi/core/providers/place_provider.dart';
import 'package:turathi/core/providers/question_provider.dart';
import 'package:turathi/core/providers/report_provider.dart';
import 'package:turathi/core/providers/request_provider.dart';
import 'package:turathi/core/providers/user_provider.dart';
import 'package:turathi/firebase_options.dart';
import 'package:turathi/utils/Router/const_router_names.dart';
import 'package:turathi/utils/Router/router_class.dart';
import 'package:turathi/utils/shared.dart';

import 'core/functions/get_current_location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform

  );
  await FirebaseAppCheck.instance.activate();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    GetCurrentLocation().performNearbySearch(context);



    print('cureent long: ${userNearestLog},cureent lat: ${userNearestLat} ');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PlaceProvider()),
        ChangeNotifierProvider.value(value: EventProvider()),
        ChangeNotifierProvider.value(value: QuestionProvider()),
        ChangeNotifierProvider.value(value: NotificationProvider()),
         ChangeNotifierProvider.value(value: UserProvider()),
         ChangeNotifierProvider.value(value: ReportProvider()),
           ChangeNotifierProvider.value(value: RequestProvider()),
           ChangeNotifierProvider.value(value: CommentProvider()),


      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: MyRouter.generateRoute,
        initialRoute: initRoute,
      ),
    );
  }
}

