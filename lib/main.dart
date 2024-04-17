import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/functions/get_current_location.dart';
import 'package:turathi/core/providers/add_place_provider.dart';
import 'package:turathi/core/providers/nearest_places_provider.dart';
import 'package:turathi/firebase_options.dart';
import 'package:turathi/utils/Router/const_router_names.dart';
import 'package:turathi/utils/Router/router_class.dart';
import 'package:turathi/utils/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        ChangeNotifierProvider.value(value: NearestPlacesProvider()),
        ChangeNotifierProvider.value(value: AddPlacesProvider()),
        /////here at the right give it model
        // ChangeNotifierProvider.value(value: PlaceProvider()),/////here at the right give it model
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: MyRouter.generateRoute,
        initialRoute: initRoute,
      ),
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       home: ImageUploader(),
//     );
//   }
// }
