import 'package:flutter/material.dart';
import 'package:turathi/utils/layoutManager.dart';

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
                          Icon(Icons.info, color: Color(0xff263238)),
                          SizedBox(width: LayoutManager.widthNHeight0(context, 0) * 0.015),
                          Text(
                            'About us',
                            style: TextStyle(
                              fontSize: LayoutManager.widthNHeight0(context, 1) * 0.038,
                              fontFamily: 'KohSantepheap',
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
                          Icon(Icons.logout, color: Color(0xff263238)),
                          SizedBox(width: LayoutManager.widthNHeight0(context, 0) * 0.015),
                          Text(
                            'Sgin out',
                            style: TextStyle(
                              fontSize: LayoutManager.widthNHeight0(context, 1) * 0.038,
                              fontFamily: 'KohSantepheap',
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
