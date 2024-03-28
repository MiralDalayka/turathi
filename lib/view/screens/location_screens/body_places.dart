import 'package:flutter/material.dart';
import 'package:turathi/core/functions/calculate_distanceInKm.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/shared.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/placesdetails_screens/details_place.dart';
import 'package:turathi/view/widgets/place_card.dart';

import '../../../utils/Router/const_router_names.dart';

class BodyPlaces extends StatefulWidget {
  final String tab;

  const BodyPlaces({Key? key, required this.tab}) : super(key: key);

  @override
  State<BodyPlaces> createState() => _BodyPlacesState();
}

class _BodyPlacesState extends State<BodyPlaces> {
  List<PlaceModel> favoritePlaces =
      demoPlaces.where((placeModel) => placeModel.isFavourite).toList();

  bool get isNearestPlaceTab => widget.tab == "Nearest Place";

  @override
  Widget build(BuildContext context) {
    double cardWidth = 150;
    double spacingWidth = 10;
    double totalWidth = cardWidth + spacingWidth;

    int crossAxisCount =
        MediaQuery.of(context).size.width ~/ totalWidth; //number of col

    if (isNearestPlaceTab && nearestLat == 0 && nearestLog == 0) {
    
      return Center(
        child: Center(
                      child: Padding(
                        padding:  EdgeInsets.only(top: LayoutManager.widthNHeight0(context, 1)*0.45),
                        child: Column(
                          children: [
                            SizedBox(height:  LayoutManager.widthNHeight0(context, 1)*0.02),
                            Text(
                              "You Have To Choose",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ThemeManager.primary,
                                fontFamily: "KohSantepheap",
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(height:  LayoutManager.widthNHeight0(context, 1)*0.025),
                            Text(
                              " The Nearest Point To You!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "KohSantepheap",
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
      );
    }
  else if (isNearestPlaceTab) {
  // Filter places that are within 10 km from the user's current location
  final List<PlaceModel> nearestPlaces = demoPlaces.where((place) {
    // Calculate the distance between the current place and the user's location
    double distanceInKm = calculateDistanceInKm(
      place.late,
      place.long,
      nearestLat,
      nearestLog,
    );
    // Return true if the distance is less than or equal to 10 km
    return distanceInKm <= 10;
  }).toList();

  return Padding(
    padding: EdgeInsets.only(
      left: LayoutManager.widthNHeight0(context, 1) * 0.05,
      right: LayoutManager.widthNHeight0(context, 1) * 0.05,
    ),
    child: GridView.builder(
      itemCount: nearestPlaces.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: cardWidth / (cardWidth + 65),
        mainAxisSpacing: 1,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final placeModel = nearestPlaces[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              placeDetailsRoute,
              arguments: placeModel,
            );
          },
          child: SizedBox(
            width: cardWidth,
            child: PlaceCard(
              placeModel: placeModel,
              onFavoriteChanged: (bool isFavourite) {
                setState(() {
                  final productIndex = demoPlaces
                      .indexWhere((p) => p.id == placeModel.id);

                  if (isFavourite) {
                    if (productIndex != -1) {
                      demoPlaces[productIndex].isFavourite = true;
                      favoritePlaces.add(demoPlaces[productIndex]);
                    }
                  } else {
                    if (productIndex != -1) {
                      demoPlaces[productIndex].isFavourite = false;
                      favoritePlaces.removeWhere((p) =>
                          p.id == placeModel.id);
                    }
                  }
                });
              },
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      placeModel: placeModel,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    ),
  );
}


    return Padding(
      padding: EdgeInsets.only(
        left: LayoutManager.widthNHeight0(context, 1) * 0.05,
        right: LayoutManager.widthNHeight0(context, 1) * 0.05,
      ),
      child: GridView.builder(
        itemCount: demoPlaces.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: cardWidth / (cardWidth + 65),
          mainAxisSpacing: 1,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final placeModel = demoPlaces[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(placeDetailsRoute, arguments: demoPlaces[index]);
            },
            child: SizedBox(
              width: cardWidth,
              child: PlaceCard(
                placeModel: placeModel,
                onFavoriteChanged: (bool isFavourite) {
                  setState(() {
                    final productIndex =
                        demoPlaces.indexWhere((p) => p.id == placeModel.id);

                    if (isFavourite) {
                      if (productIndex != -1) {
                        demoPlaces[productIndex].isFavourite = true;
                        favoritePlaces.add(demoPlaces[productIndex]);
                      }
                    } else {
                      if (productIndex != -1) {
                        demoPlaces[productIndex].isFavourite = false;
                        favoritePlaces
                            .removeWhere((p) => p.id == placeModel.id);
                      }
                    }
                  });
                },
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        placeModel: placeModel,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
