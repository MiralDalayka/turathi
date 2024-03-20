// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/utils/layout_manager.dart';
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


bool haveOfnot=false;


@override
Widget build(BuildContext context) {
  List<Widget> homeWidgets = List.generate(
    demoPlaces.length,
    (index) {
      if (demoPlaces[index].ussid == uid) {
haveOfnot=true;
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
    appBar: AppBar(
      title: Center(
        child: Text(
          'My Home',
          style: TextStyle(
            fontSize: LayoutManager.widthNHeight0(context, 1) * 0.06,
            fontWeight: FontWeight.bold,
            fontFamily: 'Kadwa',
          ),
        ),
      ),
      automaticallyImplyLeading: false,
    ),
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Divider(
            height: 1,
            color: Colors.grey[300],
          ),
          if (homeWidgets.isNotEmpty ) ...homeWidgets,
          if (homeWidgets.isEmpty || haveOfnot==false )
   
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: LayoutManager.widthNHeight0(context, 1) * 0.5),
                  child: Center(
                    child: Column(
                      children: const [
                        Text(
                          "SELL OR RENT YOUR HOME NOW!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff6482C4),
                            fontFamily: "Kadwa",
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "It looks like you haven’t sold or rented \nany homes just yet.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Kadwa",
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