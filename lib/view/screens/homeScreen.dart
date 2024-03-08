import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../utils/layoutManager.dart';
import '../../utils/theme_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ThemeManager.background,
        child: Padding(
          padding: EdgeInsets.only(top: 10, right: 8, left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi Alaa !',
                    style: TextStyle(
                      color: ThemeManager.primary,
                      fontSize: LayoutManager.widthNHeight0(context, 0) * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {}, //BACK
                    icon: Icon(
                      Icons.notifications_outlined,
                      size: 30,
                      color: ThemeManager.primary,
                    ),
                  ),
                ],
              ),
              Text(
                'Welcome',
                style: TextStyle(
                    color: ThemeManager.primary,
                    fontSize: LayoutManager.widthNHeight0(context, 0) * 0.03,
                    // fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: LayoutManager.widthNHeight0(context, 1) * 0.15,
                width: LayoutManager.widthNHeight0(context, 0),
                decoration: BoxDecoration(
                  color: ThemeManager.second,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Be Part Of Collect Data With Us",
                      style: TextStyle(
                          fontSize:
                              LayoutManager.widthNHeight0(context, 0) * 0.025),
                    ),
                    CircleAvatar(
                      backgroundColor: ThemeManager.primary,
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: ThemeManager.second,
                        ),
                        onPressed: () {
                          //BACK
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Popular Places',
                style: TextStyle(
                  color: ThemeManager.primary,
                  fontSize: LayoutManager.widthNHeight0(context, 0) * 0.025,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ImageSlideshow(
                width: double.infinity,
                height: 200,

                /// The page to show when first creating the [ImageSlideshow].
                initialPage: 0,

                /// The color to paint the indicator.
                indicatorColor: ThemeManager.primary,

                indicatorBackgroundColor: Colors.grey,
                children: [
                  Image.network(
                    'https://th.bing.com/th/id/OIP.XW8L0hrGaMGOZjKCmILZJQHaEq?rs=1&pid=ImgDetMain',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://th.bing.com/th/id/OIP.XW8L0hrGaMGOZjKCmILZJQHaEq?rs=1&pid=ImgDetMain',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://th.bing.com/th/id/OIP.XW8L0hrGaMGOZjKCmILZJQHaEq?rs=1&pid=ImgDetMain',
                    fit: BoxFit.cover,
                  ),
                ],

                autoPlayInterval: 3000,
                isLoop: true,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Events',
                    style: TextStyle(
                      color: ThemeManager.primary,
                      fontSize: LayoutManager.widthNHeight0(context, 0) * 0.025,
                    ),
                  ),
                  InkWell(
                    //BACK
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: ThemeManager.primary,
                        fontSize:
                            LayoutManager.widthNHeight0(context, 0) * 0.025,
                      ),
                    ),
                  )
                ],
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
                    Image.network(
                      'https://th.bing.com/th/id/OIP.XW8L0hrGaMGOZjKCmILZJQHaEq?rs=1&pid=ImgDetMain',
                      height: LayoutManager.widthNHeight0(context, 1) * 0.25,
                    ),
                   SizedBox(width: 20,),
                   Column(

                     children: [
                       Text("***********"),
                       Text("AAAAAAAAAAZZZZZZZZZZ"),
                       Text("QQQQQQZ")
                     ],
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
                    Image.network(
                      'https://th.bing.com/th/id/OIP.XW8L0hrGaMGOZjKCmILZJQHaEq?rs=1&pid=ImgDetMain',
                      height: LayoutManager.widthNHeight0(context, 1) * 0.25,
                    ),
                    SizedBox(width: 20,),
                    Column(

                      children: [
                        Text("***********"),
                        Text("AAAAAAAAAAZZZZZZZZZZ"),
                        Text("QQQQQQZ")
                      ],
                    )
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
