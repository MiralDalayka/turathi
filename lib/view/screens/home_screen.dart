import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../utils/layout_manager.dart';
import '../../utils/theme_manager.dart';
import '../widgets/add_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              //back
            },
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
                'Hi Alaa !',
                style: TextStyle(
                  fontFamily: 'KohSantepheap',
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
                'Good Morning',
                style: TextStyle(
                  fontFamily: 'KohSantepheap',
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
                          fontFamily: 'KohSantepheap',
                          color: ThemeManager.primary,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              LayoutManager.widthNHeight0(context, 0) * 0.0175),
                    ),
                    AddButton(onPressed: (){
                      //BACK
                    },)
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
                  fontFamily: 'KohSantepheap',
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
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: ImageSlideshow(
                      width: double.infinity,
                      height: 210,
                      initialPage: 0,
                      indicatorRadius: 6,
                      indicatorColor: ThemeManager.second,
                      indicatorBackgroundColor:
                          Color.fromRGBO(172, 166, 157, 1),
                      children: [
                        Image.asset(
                          'assets/images/img_png/slider1.png',
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'assets/images/img_png/slider1.png',
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'assets/images/img_png/slider1.png',
                          fit: BoxFit.cover,
                        ),
                      ],
                      autoPlayInterval: 3000,
                      isLoop: true,
                    ),
                  ),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: IconButton(
                      icon: Icon(
                          color: ThemeManager.second,
                          Icons.favorite_outline_sharp),
                      onPressed: () {
                        //back
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 168,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'Am aljamal',
                        style: TextStyle(
                          fontSize: 18,
                          color: ThemeManager.second,
                          fontFamily: 'KohSantepheap',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 1) * 0.018,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Text(
                      'Events',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'KohSantepheap',
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
                  InkWell(
                    //BACK
                    child: Padding(
                      padding:  EdgeInsets.only(right: LayoutManager.widthNHeight0(context, 1) * 0.02),
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'KohSantepheap',
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
              Container(
                height: LayoutManager.widthNHeight0(context, 1) * 0.25,
                width: LayoutManager.widthNHeight0(context, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: ThemeManager.second),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        'assets/images/img_png/event1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rabbath Ammon Oriental Bazaar \n Shopping Centre',
                            style: TextStyle(
                              fontFamily: 'KohSantepheap',
                              color: ThemeManager.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  LayoutManager.widthNHeight0(context, 0) *
                                      0.013,
                            
                            ),
                          ),
                          SizedBox(
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.02,
                          ),
                          Text(
                            'Open ⋅ Closes 10 PM',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'KohSantepheap',
                              color: ThemeManager.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  LayoutManager.widthNHeight0(context, 0) *
                                      0.013,
                            
                            ),
                          ),
                          SizedBox(
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.02,
                          ),
                          Text(
                            'Address: Khaled Al-Walid Amman',
                            style: TextStyle(
                              fontFamily: 'KohSantepheap',
                              color: ThemeManager.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  LayoutManager.widthNHeight0(context, 0) *
                                      0.013,
                             
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: LayoutManager.widthNHeight0(context, 1) * 0.25,
                width: LayoutManager.widthNHeight0(context, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: ThemeManager.second),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        'assets/images/img_png/event2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rabbath Ammon Oriental Bazaar \n Shopping Centre',
                            style: TextStyle(
                              fontFamily: 'KohSantepheap',
                              color: ThemeManager.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  LayoutManager.widthNHeight0(context, 0) *
                                      0.013,
                             
                            ),
                          ),
                          SizedBox(
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.02,
                          ),
                          Text(
                            'Open ⋅ Closes 10 PM',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'KohSantepheap',
                              color: ThemeManager.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  LayoutManager.widthNHeight0(context, 0) *
                                      0.013,
                            
                            ),
                          ),
                          SizedBox(
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.02,
                          ),
                          Text(
                            'Address: Khaled Al-Walid Amman',
                            style: TextStyle(
                              fontFamily: 'KohSantepheap',
                              color: ThemeManager.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  LayoutManager.widthNHeight0(context, 0) *
                                      0.013,
                            
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
