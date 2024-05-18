import 'package:flutter/material.dart';
import 'package:turathi/core/models/place_model.dart';

import '../../../../utils/Router/const_router_names.dart';

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
      child: Image.network(  placeModel.images![0] != null &&
                              placeModel.images![0].isNotEmpty
                          ? placeModel.images![0]
                          : 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
                    
      
      // Image.network(
        // placeModel.images![0],
        fit: BoxFit.cover,
      ),
    );
  }
}
