import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/view/screens/home_screen_widgets/widgets/popular_image_slider_widget.dart';

import '../../../../utils/theme_manager.dart';

class ImageSliderWidget extends StatelessWidget {
  ImageSliderWidget({super.key});

  List<PlaceModel>? popularPlaces;

  @override
  Widget build(BuildContext context) {
    //define the pop model here form controller
    popularPlaces = demoPlaces;
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: ImageSlideshow(
        width: double.infinity,
        height: 210,
        initialPage: 0,
        indicatorRadius: 6,
        indicatorColor: ThemeManager.second,
        indicatorBackgroundColor:
        Color.fromRGBO(172, 166, 157, 1),
        autoPlayInterval: 3000,
        isLoop: true,
        children: popularPlaces!.map((place) {
          return PopularPlaceWidget(placeModel: place);

        }).toList(),
      ),
    )
    ;
  }
}
