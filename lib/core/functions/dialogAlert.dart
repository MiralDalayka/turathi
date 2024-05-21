import 'package:flutter/material.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';

Widget showCustomAlertDialog(BuildContext context, String message) {
  return AlertDialog(
    backgroundColor: ThemeManager.primary,
    content: Text(
      '$message',
      style: TextStyle(
        color: Colors.white,
        fontSize: LayoutManager.widthNHeight0(context, 1) * 0.035,
        fontFamily: ThemeManager.fontFamily,
      ),
      textAlign: TextAlign.center,
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            
            },
            child: Text(
              'OK',
              style: TextStyle(
                fontFamily: ThemeManager.fontFamily,
                color: Colors.white,
                fontSize: LayoutManager.widthNHeight0(context, 1) * 0.035,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
