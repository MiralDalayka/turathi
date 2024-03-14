import 'package:flutter/material.dart';

class LayoutManager{
 static double widthNHeight0(BuildContext context, int number) {
    if (number == 0) {
      return MediaQuery.of(context).size.height;
    } else {
      return MediaQuery.of(context).size.width;
    }
  }
}