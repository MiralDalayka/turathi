import 'package:flutter/material.dart';

class ThemeManager {
  static Color primary = const Color(0xff6E232F);
  static Color second = const Color(0xffF7F3EE); //xffF0F2F6

  static Color background = const Color(0xffF0F2F6); //xffF0F2F6
  static Color textColor = const Color(0xff31221D); //31221D
  static Color containerback = const Color(0xffE2D1B9); //E2D1B9
  static Color favIcon = const Color(0xFFA74040); //0xFFA74040


  static String fontFamily = 'KohSantepheap';
  static TextStyle textStyle = TextStyle(
      fontFamily: 'KohSantepheap',
      color: textColor,
      fontWeight: FontWeight.bold,
      fontSize: 16);
 static ButtonStyle buttonStyle= ButtonStyle(
  shape: MaterialStateProperty.all(const StadiumBorder()),
  backgroundColor:
  MaterialStateProperty.all(ThemeManager.second));
}
