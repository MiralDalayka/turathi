import 'package:flutter/material.dart';
import 'package:turathi/utils/layoutManager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/profile/first_box/firstBox.dart';
import 'package:turathi/view/screens/profile/second_box/secondBox.dart';
import 'package:turathi/view/screens/profile/third_box/thirdBox.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({Key? key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       color: ThemeManager.background,
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(160.0),
                    bottomRight: Radius.circular(160.0),
                  ),
                  child: Transform.scale(
                    scale: 1.1,
                    child: Image.asset(
                      'assets/images/img_png/profile.png',
                      width: double.infinity,
                      height: LayoutManager.widthNHeight0(context, 1) * 0.54,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Positioned(
                  top: LayoutManager.widthNHeight0(context, 1) * 0.18,
                  left: LayoutManager.widthNHeight0(context, 1) * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi Alaa",
                        style: TextStyle(
                            fontSize:
                                LayoutManager.widthNHeight0(context, 1) * 0.06,
                            color: Color(0xffE8EBEC),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'KohSantepheap'),
                      ),
                      Text(
                        "Welcome Again",
                        style: TextStyle(
                            fontSize:
                                LayoutManager.widthNHeight0(context, 1) * 0.06,
                            color: Color(0xffE8EBEC),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'KohSantepheap'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: LayoutManager.widthNHeight0(context, 1) * 0.03,
                right: LayoutManager.widthNHeight0(context, 1) * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.05,
                  ),
                  const firstBox(),
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.06,
                  ),
                  const secondBox(),
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.06,
                  ),
                  const thirdBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
