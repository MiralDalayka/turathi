import 'package:flutter/material.dart';
import 'package:turathi/utils/layoutManager.dart';
import 'package:turathi/utils/theme_manager.dart';

class HeaderPart extends StatefulWidget {
  const HeaderPart({super.key});

  @override
  State<HeaderPart> createState() => _HeaderPartState();
}

class _HeaderPartState extends State<HeaderPart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:   Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
             child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Location',
                    style: TextStyle(
                      fontFamily: 'KohSantepheap',
                      color: ThemeManager.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: LayoutManager.widthNHeight0(context, 0) * 0.015,
                      shadows: const [
                        Shadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.grey,
                        size: LayoutManager.widthNHeight0(context, 0) * 0.015,
                      ),
                      SizedBox(
                        height: LayoutManager.widthNHeight0(context, 1) * 0.06,
                      ),
                      Text(
                        'Jordan Amman , Khalda ',
                        style: TextStyle(
                          fontFamily: 'KohSantepheap',
                          color: Colors.grey,
                          fontSize: LayoutManager.widthNHeight0(context, 0) * 0.014,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.028,
                  ),
                  GestureDetector(
                    onTap: () {
                    //Back
                    print("show me the map");
                    },
                    child: Container(
                    //  margin: EdgeInsets.only(right: 10,left:10),
                      height: LayoutManager.widthNHeight0(context, 1) * 0.145,
                      width: LayoutManager.widthNHeight0(context, 0),
                      decoration: BoxDecoration(
                        color: ThemeManager.second,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 2,
                            offset: const Offset(-1, -1),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Show me The Map",
                            style: TextStyle(
                                fontFamily: 'KohSantepheap',
                                color: ThemeManager.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: LayoutManager.widthNHeight0(context, 0) *
                                    0.0175,
                                     shadows: const [
                        Shadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],),
                                    
                                    
                          ),
                          SizedBox(
                            width: LayoutManager.widthNHeight0(context, 0) * 0.015,
                          ),
                          Icon(
                            Icons.map_outlined,
                            color: ThemeManager.primary,
                            size: LayoutManager.widthNHeight0(context, 0) * 0.023,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 0) * 0.005,
                  ),
                ],
              ),
                ),
                /////here
    );
  }
}