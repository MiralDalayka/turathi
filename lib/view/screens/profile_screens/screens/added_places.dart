import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/providers/place_provider.dart';
import 'package:turathi/utils/lib_organizer.dart';
import 'package:turathi/view/screens/add_data_screens/edit_place_page.dart';
import 'package:turathi/view/widgets/added_card.dart';
import 'package:turathi/view/widgets/place_card.dart';

class AddedPlaces extends StatelessWidget {
  const AddedPlaces({super.key});

  //  @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double cardWidth = 150;
    double spacingWidth = 10;
    double totalWidth = cardWidth + spacingWidth;
    int crossAxisCount =
        MediaQuery.of(context).size.width ~/ totalWidth; //number of col

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
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: Consumer<PlaceProvider>(
        builder: (context, placeProvider, child) {
          return FutureBuilder<PlaceList>(
            future: placeProvider.placeList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final currentUserID = sharedUser.id;
                print("!!!!!!!!!!!!!!!!!!$currentUserID");

                final userPlaces = snapshot.data!.places
                    .where((place) => place.userId == currentUserID)
                    .toList();

                if (userPlaces.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: LayoutManager.widthNHeight0(context, 1) *
                                  0.5),
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
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: LayoutManager.widthNHeight0(context, 1) * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              LayoutManager.widthNHeight0(context, 1) * 0.05,
                        ),
                        child: GridView.builder(
                          itemCount: userPlaces.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: cardWidth / (cardWidth + 65),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 16,
                          ),
                          itemBuilder: (context, index) {
                            final placeModel = userPlaces[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  placeDetailsRoute,
                                  arguments: placeModel,
                                );
                              },
                              child: SizedBox(
                                width: cardWidth,
                                child: AddedCard(
                                    placeModel: placeModel,
                                    onPress: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditPlace(
                                            placeModel: placeModel,
                                          ),
                                        ),
                                      );
                                    },
                                    onDelete: () {
                                      print("delete");
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                ThemeManager.primary,
                                            title: Text(
                                              'Confirm Deletion',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            content: Text(
                                              'Are you sure you want to delete this Place?',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await placeProvider
                                                      .deleteplaceprovider(
                                                          placeModel);
                                                  //  setState(() {});

                                                  ///the problem hre

                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'OK',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 32, 16),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}
