import 'package:flutter/material.dart';
import 'package:turathi/core/models/event_model.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/core/services/MapScreen%202.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/widgets/back_arrow_button.dart';
import 'package:turathi/view/widgets/deff_button%203.dart';
import 'package:turathi/view/widgets/small_Image.dart';
import 'package:intl/intl.dart';

import '../../../utils/Router/const_router_names.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({Key? key, required this.eventModel})
      : super(key: key);

  final EventModel eventModel;

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
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
            widget.eventModel.images![selectedImage],
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.1),
            colorBlendMode: BlendMode.darken,
          ),
        ),
        Positioned(
          top: height - 110,
          left: left,
          child: Text(
            widget.eventModel.name!,
            style: TextStyle(
                fontFamily: ThemeManager.fontFamily,
                color: ThemeManager.second,
                fontWeight: FontWeight.w700,
                fontSize: LayoutManager.widthNHeight0(context, 0) * 0.025,
                decoration: TextDecoration.none),
          ),
        ),

        Positioned(
            top: height - 35,
            bottom: 0,
            child: Container(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Date: ",
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
                                  DateFormat('yyyy-MM-dd – kk:mm')
                                      .format(widget.eventModel.date!),
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
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Ticket Price: ",
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
                                  widget.eventModel.ticketPrice == 0
                                      ? 'Free' :widget.eventModel.ticketPrice.toString()
                                       ,
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
                          ),
                        ],
                      ),
                    ),
                    ////////////////////////////
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "${widget.eventModel.description!} ",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.eventModel.address!,
                          style: TextStyle(
                            fontFamily: ThemeManager.fontFamily,
                            color: ThemeManager.primary,
                            fontSize: LayoutManager.widthNHeight0(context, 0) * 0.020,
                            decoration: TextDecoration.none,
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
                                    lon: widget.eventModel.longitude!,
                                    lat: widget.eventModel.latitude!),
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
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop();
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int index = 0;
                    index < widget.eventModel.images!.length;
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
                      image: widget.eventModel.images![index],
                    ),
                  ),
              ],
            )),
      ],
    );
  }
}
