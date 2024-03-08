import 'package:flutter/material.dart';
import 'package:turathi/utils/layoutManager.dart';


class firstBox extends StatefulWidget {
  const firstBox({super.key});

  @override
  State<firstBox> createState() => _firstBox();
}

class _firstBox extends State<firstBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: const Color(0xffF7F3EE),
      ),
      child: Container(
          height: LayoutManager.widthNHeight0(context, 1) * 0.5,
          padding: EdgeInsets.all(LayoutManager.widthNHeight0(context, 1) * 0.05),
          child: Column(
            children: [

              InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed("personal");
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
                            'Personal details',
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
                height:LayoutManager.widthNHeight0(context, 1) * 0.05,
              ),
              
              InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed("Change Info");
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
                            'Change Info',
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
                  // Navigator.of(context).pushNamed("Change Password");
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lock, color: Color(0xff263238)),
                          SizedBox(width: LayoutManager.widthNHeight0(context, 0) * 0.015),
                          Text(
                            'Change Password',
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
              /////
              InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed("Delete Account");
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.delete_outline, color: Color(0xff263238)),
                          SizedBox(width: LayoutManager.widthNHeight0(context, 0) * 0.015),
                          Text(
                            'Delete Account',
                            style: TextStyle(
                              fontSize:LayoutManager.widthNHeight0(context, 1) * 0.038,
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
