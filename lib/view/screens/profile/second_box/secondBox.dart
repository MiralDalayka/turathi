import 'package:flutter/material.dart';
import 'package:turathi/utils/layoutManager.dart';


class secondBox extends StatefulWidget {
  const secondBox({super.key});

  @override
  State<secondBox> createState() => _secondBox();
}

class _secondBox extends State<secondBox> {
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
                  // Navigator.of(context).pushNamed("View added places");
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, color: Color(0xff263238)),
                          SizedBox(width: LayoutManager.widthNHeight0(context, 0) * 0.015),
                          Text(
                            'View added places',
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
                  // Navigator.of(context).pushNamed("Request to be Expert");
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.email, color: Color(0xff263238)),
                          SizedBox(width: LayoutManager.widthNHeight0(context, 0) * 0.015),
                          Text(
                            'Request to be Expert',
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
