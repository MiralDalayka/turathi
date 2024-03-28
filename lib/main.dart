import 'package:flutter/material.dart';
import 'package:turathi/core/functions/get_current_location.dart';
import 'package:turathi/utils/Router/const_router_names.dart';
import 'package:turathi/utils/Router/router_class.dart';
import 'package:turathi/utils/shared.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    GetCurrentLocation().performNearbySearch(context);
    
    print('cureent long: ${usernearestLog},cureent lat: ${usernearestLat} ');

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: MyRouter.generateRoute,
      initialRoute: initRoute,
    );
  }
}
