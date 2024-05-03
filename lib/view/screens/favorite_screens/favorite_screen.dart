import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/core/providers/place_provider.dart';
import 'package:turathi/core/providers/user_provider.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/lib_organizer.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/placesdetails_screens/details_place.dart';
import 'package:turathi/view/widgets/place_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  PlaceList? favoritePlaces;

  @override
  Widget build(BuildContext context) {
    PlaceProvider provider = Provider.of<PlaceProvider>(context);
    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        title: Center(
          child: Text(
            'WishList Page',
            style: TextStyle(
              fontSize: LayoutManager.widthNHeight0(context, 1) * 0.06,
              fontWeight: FontWeight.bold,
              fontFamily: 'KohSantepheap',
              color: ThemeManager.primary,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
              LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: FutureBuilder(
        future: provider.placeList,
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data == null) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: ThemeManager.primary,
              color: ThemeManager.second,
            ));
          }
          favoritePlaces = provider.getFavPlaces(data.places);
          if (favoritePlaces!.places.isNotEmpty) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: favoritePlaces!.places.length,
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          final placeModel = favoritePlaces!.places[index];
                          return PlaceCard(
                            placeModel: placeModel,
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

                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );

          }

          return Center(
            child: Padding(
              padding: EdgeInsets.only(
                  top: LayoutManager.widthNHeight0(context, 1) * 0.45),
              child: Column(
                children: [
                  SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.02),
                  Text(
                    "SAVE YOUR FAVOURITE PLACE NOW!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeManager.primary,
                      fontFamily: "KohSantepheap",
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.025),
                  Text(
                    "It looks like you haven’t added any favourite place just yet.",
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
      ),
    );
  }
}
