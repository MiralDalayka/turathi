import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/core/providers/place_provider.dart';
import 'package:turathi/core/services/place_service.dart';
import 'package:turathi/utils/lib_organizer.dart';
import 'package:turathi/view/screens/home_screen_widgets/widgets/popular_image_slider_widget.dart';

import '../../../../utils/theme_manager.dart';

class ImageSliderWidget extends StatefulWidget {
  ImageSliderWidget({super.key});

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  PlaceList? popularPlaces;

  // getPopPlaces()async{
  //   popularPlaces =await placesProvider.getMostPopularPlaces();
  //
  // }
  @override
  Widget build(BuildContext context) {
    PlaceProvider placesProvider = Provider.of<PlaceProvider>(context);
    //future widget
    //
    return FutureBuilder(
        future: placesProvider.getPlaces(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data == null) {
            return Center(child: CircularProgressIndicator(backgroundColor: ThemeManager.primary,color: ThemeManager.second,));
          }
          popularPlaces = data;
          if (popularPlaces!.places.isNotEmpty) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: ImageSlideshow(
                width: double.infinity,
                height: 210,
                initialPage: 0,
                indicatorRadius: 6,
                indicatorColor: ThemeManager.second,
                indicatorBackgroundColor: Color.fromRGBO(172, 166, 157, 1),
                autoPlayInterval: 3000,
                isLoop: true,
                children: popularPlaces!.places!.map((place) {
                  return PopularPlaceWidget(placeModel: place);
                }).toList(),
              ),
            );
          }
          return Text("data is empty");
        });
  }
// @override
// Widget build(BuildContext context) {
//   PlaceProvider placesProvider =Provider.of<PlaceProvider>(context);
//   //future widget
//   //
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(30),
//     child: ImageSlideshow(
//       width: double.infinity,
//       height: 210,
//       initialPage: 0,
//       indicatorRadius: 6,
//       indicatorColor: ThemeManager.second,
//       indicatorBackgroundColor:
//       Color.fromRGBO(172, 166, 157, 1),
//       autoPlayInterval: 3000,
//       isLoop: true,
//       children: popularPlaces!.places!.map((place) {
//         return PopularPlaceWidget(placeModel: place);
//
//       }).toList(),
//     ),
//   );
// }
}
