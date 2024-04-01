import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:turathi/core/models/place_model.dart';

import '../../../../utils/Router/const_router_names.dart';
import '../../../../utils/theme_manager.dart';

class PopularPlaceWidget extends StatelessWidget {
  const PopularPlaceWidget({super.key, required this.placeModel});

  final PlaceModel placeModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(placeDetailsRoute, arguments: placeModel);
      },
      child: Image.asset(
        placeModel.images![0],
        fit: BoxFit.cover,
      ),
    );
  }
}
