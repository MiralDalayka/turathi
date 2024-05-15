import 'package:flutter/material.dart';
import 'package:turathi/core/services/admin_service.dart';
import 'package:turathi/utils/lib_organizer.dart';
import 'package:turathi/view/widgets/place_card.dart';

class placesAdmin extends StatefulWidget {
  const placesAdmin({Key? key}) : super(key: key);

  @override
  _placesAdminState createState() => _placesAdminState();
}

class _placesAdminState extends State<placesAdmin> {
  late Future<PlaceList> _placesFuture;

  @override
  void initState() {
    super.initState();
    _refreshPlaces();
  }

  Future<void> _refreshPlaces() async {
    setState(() {
      _placesFuture = AdminService().getPlaces();
    });
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = 150;
    double spacingWidth = 10;
    double totalWidth = cardWidth + spacingWidth;

    int crossAxisCount =
        MediaQuery.of(context).size.width ~/ totalWidth;
    
    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Admin All Places',
          style: ThemeManager.textStyle.copyWith(
            fontSize: LayoutManager.widthNHeight0(context, 1) * 0.05,
            fontWeight: FontWeight.bold,
            fontFamily: ThemeManager.fontFamily,
            color: ThemeManager.primary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
              LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshPlaces,
          ),
        ],
      ),
      body: FutureBuilder<PlaceList>(
        future: _placesFuture,
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
            final userPlaces = snapshot.data!.places.toList();

            if (userPlaces.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: LayoutManager.widthNHeight0(context, 1) * 0.5,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "There Is No Places Yet.",
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
              return SingleChildScrollView(
                child: Column(
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
                          return SizedBox(
                            width: cardWidth,
                            child: PlaceCard(
                              placeModel: placeModel,
                              onPress: () {
                                Navigator.pushNamed(
                                    context, editPlacesAdminRoute,
                                    arguments: placeModel);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
