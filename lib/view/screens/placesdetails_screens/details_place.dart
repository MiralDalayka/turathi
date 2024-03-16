import 'package:flutter/material.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/core/services/MapScreen%202.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/widgets/back_arrow_button.dart';
import 'package:turathi/view/widgets/deff_button%203.dart';
import 'package:turathi/view/widgets/small_Image.dart';

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
            widget.placeModel.images[selectedImage],
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
                              SizedBox(
                                height: 3,
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
                              SizedBox(
                                height: 3,
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
                                                "assets/images/img_png/like.png"),
                                            onPressed: () {
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
                            LayoutManager.widthNHeight0(context, 1) * 0.0355,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),

                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.06,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: LayoutManager.widthNHeight0(context, 0) * 0.2,
                          child: Text(
                            "${widget.placeModel.status}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeManager.primary,
                              fontFamily: ThemeManager.fontFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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
                        ),
                        defaultButton3(
                          fontSize:
                              LayoutManager.widthNHeight0(context, 1) * 0.045,
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
                                    lon: widget.placeModel.long,
                                    lat: widget.placeModel.late),
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
            )),
        Positioned(
            top: LayoutManager.widthNHeight0(context, 1) * 0.1, //45,
            left: 10,
            child:IconButton(onPressed: (){
     Navigator.of(context).pushReplacementNamed("bottomScreen");
    }, icon:Icon( Icons.arrow_back_sharp,color: Colors.white,size: 25,))
            //  BackArrowButton(
            //   color: Colors.white,
            // )
            
            
            ),


        Positioned(
          top: LayoutManager.widthNHeight0(context, 1) * 0.135, //45,
          left: LayoutManager.widthNHeight0(context, 0) * 0.37, //310
          child: GestureDetector(
            onTap: () {
              //BACK
              print("Report button");
            },
            child: Container(
              width: LayoutManager.widthNHeight0(context, 0) * 0.082,
              height: 25,
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
        ),
        Positioned(
          top: LayoutManager.widthNHeight0(context, 1) * 0.22, // 80,

          left: LayoutManager.widthNHeight0(context, 0) * 0.39, //310
          child: GestureDetector(
            onTap: () {
              setState(() {
                widget.placeModel.toggleFavorite();
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
                color: widget.placeModel.isFavourite
                    ? ThemeManager.favIcon
                    : ThemeManager.second,
              ),
            ),
          ),
        ),
        Positioned(
          top: LayoutManager.widthNHeight0(context, 1) * 0.55,
          left: LayoutManager.widthNHeight0(context, 0) * 0.395, //340,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int index = 0;
                  index < widget.placeModel.images.length;
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
                    image: widget.placeModel.images[index],
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
