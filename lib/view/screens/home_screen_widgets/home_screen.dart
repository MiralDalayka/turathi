import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/functions/dialog_signin.dart';
import 'package:turathi/core/providers/event_provider.dart';
import 'package:turathi/core/services/user_service.dart';
import 'package:turathi/utils/lib_organizer.dart';
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
  EventList? eventsList;
UserService userService =UserService();
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
    EventProvider eventProvider = Provider.of<EventProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        toolbarHeight: LayoutManager.widthNHeight0(context, 0) * 0.04,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_none_outlined,
              color: ThemeManager.primary,
              // size:LayoutManager.widthNHeight0(context, 0) * 2,//here
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
                "Hi ${usershared.name ?? "Guest"}".toUpperCase(),
                style: TextStyle(
                  fontFamily: ThemeManager.fontFamily,
                  color: ThemeManager.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: LayoutManager.widthNHeight0(context, 0) * 0.03,
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
                  letterSpacing: 4.5,
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
                height: LayoutManager.widthNHeight0(context, 1) * 0.15,
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
                        final currentUser = UserService().auth.currentUser;
                        if (currentUser != null && currentUser.isAnonymous) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                showCustomAlertDialog(context,
                                    "You Have To SignIn First \nTo Add Place!"),
                          );
                        } else {
                          Navigator.of(context).pushNamed(addNewPlaceRoute);
                        }
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
                      fontSize:
                          LayoutManager.widthNHeight0(context, 0) * 0.0165,
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
                      Navigator.of(context).pushNamed(eventsRoute,
                          arguments: eventsList!.events);
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
                              LayoutManager.widthNHeight0(context, 0) * 0.0165,
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
                height: LayoutManager.widthNHeight0(context, 1) * 0.03,
              ),
              FutureBuilder(
                future: eventProvider.eventList,
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if (data == null) {
                    return Center(child: CircularProgressIndicator(backgroundColor: ThemeManager.primary,color: ThemeManager.second,));
                  }
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return Center(child: CircularProgressIndicator());
                  // } else if (snapshot.hasError) {
                  //   return Center(child: Text('Error: ${snapshot.error}'));
                  // } else
                  eventsList =  data;

                    if (data.events.isNotEmpty) {
                      return Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ViewEvent(
                                eventModel: eventsList!.events[0],
                                flag: false,
                              ),
                              SizedBox(
                                height: LayoutManager.widthNHeight0(context, 1) *
                                    0.04,
                              ),
                              ViewEvent(
                                eventModel: eventsList!.events[1],
                                flag: false,
                              ),
                            ],
                          ),
                        ),
                      );

                    }

                  return Padding(
                    padding:  EdgeInsets.only(top: LayoutManager.widthNHeight0(context, 1)*0.2),
                    child: Center(
                      child: Text(
                        'No Events are available',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: ThemeManager.fontFamily,
                          color: ThemeManager.primary,
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
