// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/placesdetails_screens/details_place.dart';
import 'package:turathi/view/widgets/added_card.dart';

class AddedPlaces extends StatefulWidget {
  const AddedPlaces({super.key});

  @override
  State<AddedPlaces> createState() => _AddedPlaces();
}

class _AddedPlaces extends State<AddedPlaces> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String uid;
  bool moon = false;

  @override
  void initState() {
    super.initState();
    fetchUserUid();
  }

  void fetchUserUid() {
    final User? user = auth.currentUser;
    if (user != null) {
      uid = user.uid;
    } else {
      print('User is not authenticated');
    }
  }

  void onDeletePressed(PlaceModel deletedProduct) {
    setState(() {
      demoPlaces.remove(deletedProduct);
    });
  }

  bool haveOfnot = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> homeWidgets = List.generate(
      demoPlaces.length,
      (index) {
        if (demoPlaces[index].userID == uid) {
          haveOfnot = true;
          return Padding(
            padding: const EdgeInsets.all(0),
            child: AddedCard(
              placeModel: demoPlaces[index],
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      placeModel: demoPlaces[index],
                    ),
                  ),
                );
              },
              onFavoriteChanged: (bool isFavorite) {},
              onDeletePressed: () {
                onDeletePressed(demoPlaces[index]);
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );

    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Added Places',
          style: ThemeManager.textStyle.copyWith(
            fontSize: LayoutManager.widthNHeight0(context, 1) * 0.05,
            fontWeight: FontWeight.bold,
            fontFamily: ThemeManager.fontFamily,
            color: ThemeManager.primary,
          ),
        ),
        // automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
           
            if (homeWidgets.isNotEmpty) ...homeWidgets,
            if (homeWidgets.isEmpty || haveOfnot == false)
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: LayoutManager.widthNHeight0(context, 1) * 0.5),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Add any historical place u know now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeManager.primary,
                              fontFamily: ThemeManager.fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "It looks like you haven’t add \nany Place just yet.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: ThemeManager.fontFamily,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
