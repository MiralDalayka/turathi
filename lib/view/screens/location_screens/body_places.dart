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
  bool get isMyLocationTab => widget.tab == "My Location";

  @override
  Widget build(BuildContext context) {
    double cardWidth = 150;
    double spacingWidth = 10;
    double totalWidth = cardWidth + spacingWidth;

    int crossAxisCount =
        MediaQuery.of(context).size.width ~/ totalWidth; //number of col


//here to filter places that  within 10 km from  selected nearest location
      final List<PlaceModel> SelectednearestPlaces = demoPlaces.where((place) {
        double distanceInKm = calculateDistanceInKm(
          place.late,
          place.long,
          selectednearestLat,
          selectednearestLog,
        );

        return distanceInKm <= 10;
      }).toList();
      ///////first scenario
    if (isNearestPlaceTab &&
        (selectednearestLat == 0.0 || selectednearestLog == 0.0)) {
      return Center(
          child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: LayoutManager.widthNHeight0(context, 1) * 0.45),
          child: Column(
            children: [
              SizedBox(height: LayoutManager.widthNHeight0(context, 1) * 0.02),
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
              SizedBox(height: LayoutManager.widthNHeight0(context, 1) * 0.025),
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
    
   



       ///////second scenario
    else if(isNearestPlaceTab  && SelectednearestPlaces.length == 0 ){
        return Center(
          child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: LayoutManager.widthNHeight0(context, 1) * 0.45),
          child: Column(
            children: [
              SizedBox(height: LayoutManager.widthNHeight0(context, 1) * 0.02),
              Text(
                "There ARE No Places Nearest",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeManager.primary,
                  fontFamily: "KohSantepheap",
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: LayoutManager.widthNHeight0(context, 1) * 0.025),
              Text(
                "TO The Point You Choose.",
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


  ///////Third scenario
    
     
    else  if(isNearestPlaceTab && SelectednearestPlaces.length != 0) {
     

      return Padding(
        
        padding: EdgeInsets.only(
          left: LayoutManager.widthNHeight0(context, 1) * 0.05,
          right: LayoutManager.widthNHeight0(context, 1) * 0.05,
        ),
        child: GridView.builder(
          
          itemCount: SelectednearestPlaces.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: cardWidth / (cardWidth + 65),
            mainAxisSpacing: 1,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final placeModel = SelectednearestPlaces[index];
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





    
     //here to filter places that  within 10 km from  User nearest location (my location)
    final List<PlaceModel> UsernearestPlaces = demoPlaces.where((place) {
      double distanceInKm = calculateDistanceInKm(
        place.late,
        place.long,
        usernearestLat,
        usernearestLog,
      );

      return distanceInKm <= 10;
    }).toList();

    
         ///////first scenario
     if (isMyLocationTab &&
        (usernearestLat == 0.0 || usernearestLog == 0.0)) 
       {
      return Center(
          child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: LayoutManager.widthNHeight0(context, 1) * 0.45),
          child: Column(
            children: [
              SizedBox(height: LayoutManager.widthNHeight0(context, 1) * 0.02),
              Text(
                "You Should Allow Access To",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeManager.primary,
                  fontFamily: "KohSantepheap",
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: LayoutManager.widthNHeight0(context, 1) * 0.025),
              Text(
                "Your Location",
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



   
  ///////second scenario
else if( isMyLocationTab && UsernearestPlaces.length==0){
 return Center(
          child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: LayoutManager.widthNHeight0(context, 1) * 0.45),
          child: Column(
            children: [
              SizedBox(height: LayoutManager.widthNHeight0(context, 1) * 0.02),
              Text(
                "There IS No Places",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeManager.primary,
                  fontFamily: "KohSantepheap",
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: LayoutManager.widthNHeight0(context, 1) * 0.025),
              Text(
                "Nearest Your Location",
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

  ///////third scenario

   else if(isMyLocationTab && UsernearestPlaces.length!=0) return Padding(
      padding: EdgeInsets.only(
        left: LayoutManager.widthNHeight0(context, 1) * 0.05,
        right: LayoutManager.widthNHeight0(context, 1) * 0.05,
      ),
      child: GridView.builder(
        itemCount: UsernearestPlaces.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: cardWidth / (cardWidth + 65),
          mainAxisSpacing: 1,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final placeModel = UsernearestPlaces[index];
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

    
 print('>>>>>>>>>>>>>>>>>>>>>> ${SelectednearestPlaces.length}');
     return Container(child: Text("pop"),
    );
  }
}
