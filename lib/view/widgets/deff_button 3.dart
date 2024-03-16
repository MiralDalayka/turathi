// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:turathi/utils/theme_manager.dart';

Widget defaultButton3({
  double width = double.infinity,
  double height = 50.0,
  Color borderColor = const Color(0xff6E232F),
  Color background = const Color(0xff6E232F),
  Color textColor = const Color(0xffF7F3EE),
  final Function()? function,
  required String text,
  double fontSize = 20.0,
  double borderRadius = 0.0,
  required void Function() onPressed,
  required int borderWidth, // Change this line
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
        color: background,
         boxShadow: [
          BoxShadow(
            color: ThemeManager.primary.withOpacity(0.4),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        onPressed: onPressed, // Change this line
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: textColor,
            fontSize: fontSize,
            fontFamily: ThemeManager.fontFamily,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(-2.0, 2.0),
                blurRadius: 1.0,
                color: Colors.white.withOpacity(0.2),
              ),
            ],
          ),
        ),
      ),
    );
