import 'package:flutter/material.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';

class thirdBox extends StatefulWidget {
  const thirdBox({super.key});

  @override
  State<thirdBox> createState() => _thirdBox();
}

class _thirdBox extends State<thirdBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: const Color(0xffF7F3EE),
      ),
      child: Container(
          height: LayoutManager.widthNHeight0(context, 1) * 0.3,
          padding: EdgeInsets.all(LayoutManager.widthNHeight0(context, 1) * 0.05),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed("About us");
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                        Image.asset(
                            'assets/images/img_png/infoProfile.png',
                            width:  LayoutManager.widthNHeight0(context, 0) *
                                  0.03,
                            height: LayoutManager.widthNHeight0(context, 1) *
                                  0.054,
                          ),
                          SizedBox(width: LayoutManager.widthNHeight0(context, 0) * 0.015),
                          Text(
                            'About us',
                            style: TextStyle(
                              fontSize: LayoutManager.widthNHeight0(context, 1) * 0.038,
                              fontFamily: 'KohSantepheap',
                              color: ThemeManager.primary,
                               fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 1) * 0.05,
              ),
              InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed("Sgin out");
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                         Image.asset(
                            'assets/images/img_png/logoutProfile.png',
                            width:  LayoutManager.widthNHeight0(context, 0) *
                                  0.027,
                            height: LayoutManager.widthNHeight0(context, 1) *
                                  0.055,
                          ),
                          SizedBox(width: LayoutManager.widthNHeight0(context, 0) * 0.015),
                          Text(
                            'Sgin out',
                            style: TextStyle(
                              fontSize: LayoutManager.widthNHeight0(context, 1) * 0.038,
                              fontFamily: 'KohSantepheap',
                               color: ThemeManager.primary,
                               fontWeight: FontWeight.bold
                               
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
