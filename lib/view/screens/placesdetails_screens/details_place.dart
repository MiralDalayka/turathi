import 'package:flutter/material.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/widgets/back_arrow_button.dart';

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
            widget.placeModel.images[0],
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.1),
            colorBlendMode: BlendMode.darken,
          ),
        ),
        Positioned(
          top: height - 110,
          left: left,
          child: Text(
            widget.placeModel.title,
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
                  widget.placeModel.location,
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
                        widget.placeModel.type,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: ThemeManager.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: ThemeManager.primary,
                          decoration: TextDecoration.none,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 3,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
        Positioned(
            top: height - 35,
            bottom: 0,
            child: Container(
              height: LayoutManager.widthNHeight0(context, 0),
              width: LayoutManager.widthNHeight0(context, 1),
              decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(35))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25, top: 20, bottom: 15),
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
                              Text(
                                "+${widget.placeModel.distance} Km",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ThemeManager.primary,
                                  fontFamily: ThemeManager.fontFamily,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Comments",
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
                              Column(
                                children: [
                                  Text(
                                    "( ${widget.placeModel.comments_counter} )",
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
                              )
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          print("Thumbs-up clicked ");
                                        },
                                        icon: Icon(
                                          Icons.thumb_up_off_alt_outlined,
                                          color: ThemeManager.primary,
                                        ),
                                      ),
                                      Text(
                                        "${widget.placeModel.like}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: ThemeManager.textColor
                                              .withOpacity(0.7),
                                          decoration: TextDecoration.none,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${widget.placeModel.disLike}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: ThemeManager.textColor
                                              .withOpacity(0.7),
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          print("Thumbs-down clicked ");
                                        },
                                        icon: Icon(
                                          Icons.thumb_down_off_alt_outlined,
                                          color: ThemeManager.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
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
                      "( ${widget.placeModel.description} )",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ThemeManager.textColor.withOpacity(0.7),
                        fontFamily: ThemeManager.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.placeModel.status}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: ThemeManager.primary,
                            fontFamily: ThemeManager.fontFamily,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        
                      ],
                    )
                  ],
                ),
              ),
            )),
        Positioned(
            top: 30,
            left: 10,
            child: BackArrowButton(
              color: Colors.white,
            )),
      ],
    );
  }
}
