import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turathi/core/functions/calculate_distanceInKm.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/core/services/MapScreen%202.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/shared.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/placesdetails_screens/comments_place_screen.dart';
import 'package:turathi/view/widgets/back_arrow_button.dart';
import 'package:turathi/view/widgets/comment_circle.dart';
import 'package:turathi/view/widgets/deff_button%203.dart';
import 'package:turathi/core/functions/new_line_after.dart';
import 'package:turathi/view/widgets/small_Image.dart';

import '../../../utils/Router/const_router_names.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.placeModel}) : super(key: key);

  final PlaceModel placeModel;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int selectedImage = 0;

  Key? get key => null;

  @override
  Widget build(BuildContext context) {
    var height = LayoutManager.widthNHeight0(context, 0) * 0.55;
    double left = 20;
    return Stack(
      children: <Widget>[
        SizedBox(
          height: height,
          width: double.infinity,
          child: Image.asset(
            widget.placeModel.images![selectedImage],
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.1),
            colorBlendMode: BlendMode.darken,
          ),
        ),
        Positioned(
          top: height - 110,
          left: left,
          child: Text(
            widget.placeModel.title!,
            style: TextStyle(
                fontFamily: ThemeManager.fontFamily,
                color: ThemeManager.second,
                fontWeight: FontWeight.w700,
                fontSize: LayoutManager.widthNHeight0(context, 0) * 0.032,
                decoration: TextDecoration.none),
          ),
        ),
        Positioned(
            top: height - 70,
            left: left,
            child: Row(
              children: [
                Text(
                  widget.placeModel.location!,
                  style: TextStyle(
                    fontFamily: ThemeManager.fontFamily,
                    color: ThemeManager.second,
                    fontSize: LayoutManager.widthNHeight0(context, 0) * 0.015,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 85,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Color(0xFFE2D1B9).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(33),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        widget.placeModel.state!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: ThemeManager.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: ThemeManager.primary,
                          decoration: TextDecoration.none,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 2,
                              offset: Offset(-1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ), //
              ],
            )),
        Positioned(
          top: height - 35,
          bottom: 0,
          child: Container(
            width: LayoutManager.widthNHeight0(context, 1),
            height: LayoutManager.widthNHeight0(context, 0),
            decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(35))),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25, top: 20, bottom: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ThemeManager.containerback.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffE9E6E2).withOpacity(0.4),
                            spreadRadius: 0,
                            blurRadius: 12,
                            offset: Offset(3, -3),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Distance",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      ThemeManager.textColor.withOpacity(0.7),
                                  fontFamily: ThemeManager.fontFamily,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                getFormattedDistance(
                                  calculateDistanceInKm(
                                      widget.placeModel.late!,
                                      widget.placeModel.long!,
                                      userNearestLat,
                                      userNearestLog),
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ThemeManager.primary,
                                  fontFamily: ThemeManager.fontFamily,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width:
                                LayoutManager.widthNHeight0(context, 1) * 0.1,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Comments",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ThemeManager.textColor
                                          .withOpacity(0.7),
                                      fontFamily: ThemeManager.fontFamily,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context).pushNamed(
                                    //   commentsPlaceRoute,
                                    //   // arguments: widget.placeModel.id,
                                    // );\

                                    ////////////here we have to chnage to pushNamed
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CommentsPlace(
                                            place: widget.placeModel),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.comment_outlined,
                                    color: ThemeManager.primary,
                                    size: LayoutManager.widthNHeight0(
                                            context, 1) *
                                        0.05,
                                  )),
                            ],
                          ),
                          SizedBox(
                            width:
                                LayoutManager.widthNHeight0(context, 1) * 0.1,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                          height: LayoutManager.widthNHeight0(
                                                  context, 1) *
                                              0.05, //30.0,
                                          width: LayoutManager.widthNHeight0(
                                                  context, 0) *
                                              0.035, //18.0,
                                          child: IconButton(
                                            padding: EdgeInsets.all(0.0),
                                            icon: Image.asset(
                                                "assets/images/img_png/like.png"),
                                            onPressed: () {
                                              setState(() {
                                                widget.placeModel.like =
                                                    widget.placeModel.like! + 1;
                                              });
                                              print("Thumbs-up clicked ");
                                            },
                                          )),
                                      SizedBox(
                                        height: LayoutManager.widthNHeight0(
                                                context, 1) *
                                            0.015,
                                      ),
                                      Text(
                                        "${widget.placeModel.like}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: ThemeManager.fontFamily,
                                          color: ThemeManager.textColor
                                              .withOpacity(0.7),
                                          decoration: TextDecoration.none,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: LayoutManager.widthNHeight0(
                                            context, 0) *
                                        0.01,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${widget.placeModel.disLike}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: ThemeManager.fontFamily,
                                          color: ThemeManager.textColor
                                              .withOpacity(0.7),
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      SizedBox(
                                        height: LayoutManager.widthNHeight0(
                                                context, 1) *
                                            0.015,
                                      ),
                                      Container(
                                          height: LayoutManager.widthNHeight0(
                                                  context, 1) *
                                              0.05, //30.0,
                                          width: LayoutManager.widthNHeight0(
                                                  context, 0) *
                                              0.035, //18.0,
                                          child: new IconButton(
                                            padding: new EdgeInsets.all(0.0),
                                            icon: new Image.asset(
                                                "assets/images/img_png/dislike.png"),
                                            onPressed: () {
                                              setState(() {
                                                widget.placeModel.disLike =widget.placeModel.disLike!+ 1;
                                              });
                                              print("Thumbs-down clicked ");
                                            },
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    ////////////////////////////
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "${widget.placeModel.description} ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ThemeManager.textColor.withOpacity(0.7),
                        fontFamily: ThemeManager.fontFamily,
                        fontSize:
                            LayoutManager.widthNHeight0(context, 1) * 0.0357,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),

                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.06,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: LayoutManager.widthNHeight0(context, 0) * 0.2,
                          child: AutoSizeText(
                            addNewLineAfterChars(
                              widget.placeModel.status!,
                              20,
                            ),
                            maxLines: 3,
                            textAlign: TextAlign.start,
                            style: ThemeManager.textStyle.copyWith(
                              color: ThemeManager.primary,
                              decoration: TextDecoration.none,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 2.0,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                              ],
                            ),
                          ),

                          // AutoSizeText(
                          //     maxLines: 3,
                          //     widget.placeModel.status,
                          //     textAlign: TextAlign.start,
                          //     style: ThemeManager.textStyle.copyWith(
                          //       color: ThemeManager.primary,
                          //       decoration: TextDecoration.none,
                          //       shadows: <Shadow>[
                          //         Shadow(
                          //           offset: Offset(5.0, 5.0),
                          //           blurRadius: 2.0,
                          //           color: Colors.black.withOpacity(0.25),
                          //         ),
                          //       ],
                          //     )
                          //     )
                        ),
                        defaultButton3(
                          text: 'Show Map',
                          width: LayoutManager.widthNHeight0(context, 1) * 0.36,
                          borderRadius: 18,
                          background: ThemeManager.primary,
                          textColor: ThemeManager.second,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreenLocation(
                                    lon: widget.placeModel.long!,
                                    lat: widget.placeModel.late!),
                              ),
                            );
                          },
                          borderWidth: 0,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: LayoutManager.widthNHeight0(context, 1) * 0.1, //45,
            left: 10,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .popAndPushNamed(bottomNavRoute); //change it
                },
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.white,
                  size: 25,
                ))),
        Positioned(
            top: LayoutManager.widthNHeight0(context, 1) * 0.135, //45,
            right: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(addReportRoute,
                        arguments: widget.placeModel.id);
                  },
                  child: Container(
                    width: LayoutManager.widthNHeight0(context, 0) * 0.082,
                    height: LayoutManager.widthNHeight0(context, 0) * 0.025,
                    decoration: BoxDecoration(
                      color: ThemeManager.favIcon.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Report",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: ThemeManager.fontFamily,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: ThemeManager.second,
                            decoration: TextDecoration.none,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 2,
                                offset: Offset(-1, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      //BACK
                      // widget.placeModel.toggleFavorite();
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ThemeManager.second.withOpacity(0.25),
                    ),
                    child: Icon(
                      Icons.favorite,
                      size: 25,
                      color: widget.placeModel.isFavourite!
                          ? ThemeManager.favIcon
                          : ThemeManager.second,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int index = 0;
                        index < widget.placeModel.images!.length;
                        index++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SmallImage(
                          isSelected: index == selectedImage,
                          press: () {
                            setState(() {
                              selectedImage = index;
                            });
                          },
                          image: widget.placeModel.images![index],
                        ),
                      ),
                  ],
                )
              ],
            )),
      ],
    );
  }
}

String getFormattedDistance(double distance) {
  if (distance < 1) {
    return "-1Km";
  } else if (distance < 10) {
    return "-10km";
  } else {
    return "+${distance.toInt()} Km";
  }
}
