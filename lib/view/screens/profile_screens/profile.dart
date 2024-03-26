import 'package:flutter/material.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/screens/profile_screens/widgets/firstBox.dart';
import 'package:turathi/view/screens/profile_screens/widgets/secondBox.dart';
import 'package:turathi/view/screens/profile_screens/widgets/thirdBox.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() =>_ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
         color: ThemeManager.background,
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(150.0),
                      bottomRight: Radius.circular(150.0),
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
                    top: LayoutManager.widthNHeight0(context, 1) * 0.155,
                    left: LayoutManager.widthNHeight0(context, 1) * 0.08,
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
                              fontFamily: 'KohSantepheap',
        
                               ),
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
                      height: LayoutManager.widthNHeight0(context, 1) * 0.08,
                    ),
                    const firstBox(),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.035,
                    ),
                    const SecondBox(),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.035,
                    ),
                    const thirdBox(),
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
