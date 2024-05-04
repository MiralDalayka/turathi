import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/functions/calculate_distanceInKm.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/core/providers/place_provider.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/shared.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/placesdetails_screens/details_place.dart';
import 'package:turathi/view/widgets/place_card.dart';

import '../../../utils/Router/const_router_names.dart';

class BodyPlaces extends StatefulWidget {
  final String tab;
  final int dis_num;

  BodyPlaces({Key? key, required this.tab, required this.dis_num}) : super(key: key);

  @override
  State<BodyPlaces> createState() => _BodyPlacesState();
  
}

class _BodyPlacesState extends State<BodyPlaces> {

  bool get isNearestPlaceTab => widget.tab == "Nearest Place";

  bool get isMyLocationTab => widget.tab == "My Location";

  List<PlaceModel>? nearestPlacesList;

  PlaceList? placesList;

  @override
  Widget build(BuildContext context) {
    
    print("&&&&&&&${widget.dis_num}");
    log("Build the tabs $isMyLocationTab and $isNearestPlaceTab");
    double cardWidth = 150;
    double spacingWidth = 10;
    double totalWidth = cardWidth + spacingWidth;

    int crossAxisCount =
        MediaQuery.of(context).size.width ~/ totalWidth; //number of col
    final PlaceProvider placesProvider = Provider.of<PlaceProvider>(context);

    var dataList = [];
    if (isMyLocationTab) {
      log("%%%%%%%%%%%%%");
     
      dataList.addAll([userNearestLat, userNearestLog]); 
    } else {
      log("**********");

      dataList.addAll([selectedNearestLat, selectedNearestLog]);
      log("$selectedNearestLat,$selectedNearestLog");
    }

    if (dataList.first == 0.0 || dataList.last == 0.0) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: LayoutManager.widthNHeight0(context, 1) * 0.45),
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
              const Text(
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
      );
    }

    return FutureBuilder(
      future: placesProvider.getNearestPlaceList(dataList.first, dataList.last, widget.dis_num),
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        placesList = data;
        if (placesList!.places.isNotEmpty) {
          return Padding(
            padding: EdgeInsets.only(top: LayoutManager.widthNHeight0(context, 1) * 0.04, left: LayoutManager.widthNHeight0(context, 1) * 0.035, right: LayoutManager.widthNHeight0(context, 1) * 0.035),
            child: GridView.builder(
              itemCount: placesList!.places.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: cardWidth / (cardWidth + 65),
                mainAxisSpacing: 8, //between top
                crossAxisSpacing: 16, //between
              ),
              itemBuilder: (context, index) {
                final placeModel = placesList!.places[index];
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

                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              placeModel: placeModel,
                              // dis_num
                            ),
                            ////
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
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: LayoutManager.widthNHeight0(context, 1) * 0.45),
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
                const Text(
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
        );
      },
    );
  }
}
