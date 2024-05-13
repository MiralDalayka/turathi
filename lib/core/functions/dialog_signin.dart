import 'package:flutter/material.dart';
import 'package:turathi/core/models/user_model.dart';
import 'package:turathi/core/services/user_service.dart';
import 'package:turathi/utils/Router/const_router_names.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/shared.dart';
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
              sharedUser = UserModel(
                name: null,
                email: null,
                phone: null,
                longitude: null,
                latitude: null,
              );

              Navigator.of(context).pop();
              UserService().signOut();

              Navigator.of(context).pushNamed(signIn);
            },
            child: Text(
              'SignIn',
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
