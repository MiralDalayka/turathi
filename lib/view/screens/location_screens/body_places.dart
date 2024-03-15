import 'package:flutter/material.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/utils/layoutManager.dart';
import 'package:turathi/view/screens/places_screens/details_place.dart';
import 'package:turathi/view/widgets/place_card.dart';

class BodyPlaces extends StatefulWidget {
  final String tab; 

  const BodyPlaces({Key? key, required this.tab}) : super(key: key);

  @override
  State<BodyPlaces> createState() => _BodyPlacesState();
}

class _BodyPlacesState extends State<BodyPlaces> {
  List<PlaceModel> favoritePlaces = demoPlaces.where((placeModel) => placeModel.isFavourite).toList();

  @override
  Widget build(BuildContext context) {
    double cardWidth = 150;
    double spacingWidth = 10;
    double totalWidth = cardWidth + spacingWidth;

    int crossAxisCount = MediaQuery.of(context).size.width ~/ totalWidth; //number of col

    return Padding(
      padding: EdgeInsets.only(
       left: 
        LayoutManager.widthNHeight0(context, 1) * 0.05,
        right:  
        LayoutManager.widthNHeight0(context, 1) * 0.05,
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(placeModel: demoPlaces[index]),
                ),
              );
            },
            child: SizedBox(
              width: cardWidth,
              child: PlaceCard(
                placeModel: placeModel,
                onFavoriteChanged: (bool isFavourite) {
                  setState(() {
                    final productIndex = demoPlaces.indexWhere((p) => p.id == placeModel.id);

                    if (isFavourite) {
                      if (productIndex != -1) {
                        demoPlaces[productIndex].isFavourite = true;
                        favoritePlaces.add(demoPlaces[productIndex]);
                      }
                    } else {
                      if (productIndex != -1) {
                        demoPlaces[productIndex].isFavourite = false;
                        favoritePlaces.removeWhere((p) => p.id == placeModel.id);
                      }
                    }
                  }
                  );
                },
                onPress: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}