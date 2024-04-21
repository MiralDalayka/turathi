import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:turathi/core/models/user_model.dart';
import 'package:turathi/view/screens/events_screens/widgets/event_widget_view.dart';
import 'package:turathi/view/screens/home_screen_widgets/widgets/popular_image_slider.dart';
import '../../../core/models/event_model.dart';
import '../../../utils/Router/const_router_names.dart';
import '../../../utils/layout_manager.dart';
import '../../../utils/shared.dart';
import '../../../utils/theme_manager.dart';
import '../../widgets/add_button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<EventModel>? eventsList;

  String _greeting = '';

  @override
  void initState() {
    super.initState();
    _setGreeting();
  }

  void _setGreeting() {
    DateTime now = DateTime.now();
    if (now.hour < 12) {
      setState(() {
        _greeting = 'Good Morning';
      });
    } else if (now.hour < 18) {
      setState(() {
        _greeting = 'Good Afternoon';
      });
    } else {
      setState(() {
        _greeting = 'Good Evening';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //change it

   // eventsList = events;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        toolbarHeight: LayoutManager.widthNHeight0(context, 0) * 0.04,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_none_outlined,
              color: ThemeManager.primary,
            ),
            onPressed: () {},
            iconSize: LayoutManager.widthNHeight0(context, 0) * 0.034,
          ),
          SizedBox(width: LayoutManager.widthNHeight0(context, 0) * 0.015),
        ],
      ),
      body: Container(
        color: ThemeManager.background,
        child: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi ${user.name??"Guest"}".toUpperCase(),
                style: TextStyle(
                  fontFamily: ThemeManager.fontFamily,
                  color: ThemeManager.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: LayoutManager.widthNHeight0(context, 0) * 0.034,
                  shadows: const [
                    Shadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
              Text(
                _greeting,
                style: TextStyle(
                  fontFamily: ThemeManager.fontFamily,
                  color: ThemeManager.primary,
                  fontSize: LayoutManager.widthNHeight0(context, 0) * 0.02,
                  letterSpacing: 4,
                  fontWeight: FontWeight.bold,
                  shadows: const [
                    Shadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 1) * 0.026,
              ),
              Container(
                height: LayoutManager.widthNHeight0(context, 1) * 0.16,
                width: LayoutManager.widthNHeight0(context, 0),
                decoration: BoxDecoration(
                  color: ThemeManager.second,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Be Part Of Collect Data With Us",
                      style: TextStyle(
                          fontFamily: ThemeManager.fontFamily,
                          color: ThemeManager.primary,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              LayoutManager.widthNHeight0(context, 0) * 0.0175),
                    ),
                    AddButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(addNewPlaceRoute);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 0) * 0.014,
              ),
              Text(
                'Popular Places',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: ThemeManager.fontFamily,
                  color: ThemeManager.primary,
                  fontSize: LayoutManager.widthNHeight0(context, 0) * 0.015,
                  shadows: const [
                    Shadow(
                      color: Colors.grey,
                      blurRadius: 0.01,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 1) * 0.018,
              ),
              ImageSliderWidget(),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 1) * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Events',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: ThemeManager.fontFamily,
                      color: ThemeManager.primary,
                      fontSize: LayoutManager.widthNHeight0(context, 0) * 0.015,
                      shadows: const [
                        Shadow(
                          color: Colors.grey,
                          blurRadius: 0.01,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //nav to all events
                      Navigator.of(context)
                          .pushNamed(eventsRoute, arguments: eventsList);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          right:
                              LayoutManager.widthNHeight0(context, 1) * 0.02),
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: ThemeManager.fontFamily,
                          color: ThemeManager.primary,
                          fontSize:
                              LayoutManager.widthNHeight0(context, 0) * 0.015,
                          shadows: const [
                            Shadow(
                              color: Colors.grey,
                              blurRadius: 0.01,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 1) * 0.02,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ViewEvent(
                        eventModel: eventsList![0],
                        flag: false,
                      ),
                      SizedBox(
                        height: LayoutManager.widthNHeight0(context, 1) * 0.04,
                      ),
                      ViewEvent(
                        eventModel: eventsList![1],
                        flag: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
