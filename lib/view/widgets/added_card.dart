// ignore_for_file: use_super_parameters, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';

class AddedCard extends StatefulWidget {
  const AddedCard({
    Key? key,
    this.width = 300,
    this.aspectRatio = 1.76,
    required this.placeModel,
    required this.onPress,
    required this.onFavoriteChanged,
    required this.onDeletePressed,
  }) : super(key: key);

  final double width, aspectRatio;
  final PlaceModel placeModel;
  final VoidCallback onPress;
  final Function(bool isFavourite) onFavoriteChanged;
  final Function() onDeletePressed;

  @override
  // ignore: library_private_types_in_public_api
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<AddedCard> {
  String userId = "";
  void onDeletePressed() async {
    print('Delete button pressed');

    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user?.uid;
      print(uid);

      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('House').get();

      print('Number of documents: ${snapshot.size}');
      int counter = 0;
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        List<dynamic>? dataList = doc['dataList'];
        counter++;
        String homeId = widget.placeModel.id;
        if (dataList != null) {
          String str = dataList[7].toString();

          int openingBraceIndex = str.indexOf("{");
          int closingBraceIndex = str.indexOf("}");

          userId =
              str.substring(openingBraceIndex + 1, closingBraceIndex).trim();

//  print('$counter + $userId');
        }

// print('%%%%%%%%%%%%%%%%$uid');

        if (dataList != null &&
            userId == 'userid: ${uid.toString()}' &&
            homeId == doc.id) {
          await doc.reference.delete();

          print('Place deleted successfully');
        }
      }
    } catch (e) {
      print('Error deleting place: $e');
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onEditPressed() {
    print('Edit button pressed');
  }

 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xffF0F2F6),
          ),
          padding: EdgeInsets.all(12),
          width: LayoutManager.widthNHeight0(context, 1) * 0.9,
          child: GestureDetector(
            onTap: widget.onPress,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: widget.aspectRatio,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffCCD8F4).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                widget.placeModel.images[0],
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              top: LayoutManager.widthNHeight0(context, 0) * 0.01,
                              left: LayoutManager.widthNHeight0(context, 1) * 0.02,
                              height: LayoutManager.widthNHeight0(context, 1) * 0.084,
                              child: Container(
                                padding: EdgeInsets.all(
                                    LayoutManager.widthNHeight0(context, 1) * 0.01),
                                decoration: BoxDecoration(
                                  color: Color(0xffF0F2F6),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "checked",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily:ThemeManager.fontFamily,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: LayoutManager.widthNHeight0(context, 1) * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      
                       
                      ],
                    ),
                    Container(
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed:(){


                               showDialog(
                                  
                                    context: context,
                                    builder: (BuildContext context) {

                                      return AlertDialog(
                                       backgroundColor: ThemeManager.primary,
                                        title: Text('Confirm Deletion',style: TextStyle(color: Colors.white),),
                                        content: Text(
                                            'Are you sure you want to delete this Home?',style: TextStyle(color: Colors.white),),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancel',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              onDeletePressed();
                                              widget.onDeletePressed();
                                            },
                                            child: Text('OK',style: TextStyle(color: Color.fromARGB(255, 255, 32, 16),fontWeight: FontWeight.bold),),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: Color(0xff6482C4),
                            ),
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: ThemeManager.fontFamily,
                              ),
                            ),
                          ),
                          SizedBox(width: LayoutManager.widthNHeight0(context, 1) * 0.02),
                        
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: LayoutManager.widthNHeight0(context, 1) * 0.03),
      ],
    );
  }
}
