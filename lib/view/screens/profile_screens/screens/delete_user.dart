import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/controllers/signup_controller.dart';
import 'package:turathi/core/models/user_model.dart';
import 'package:turathi/core/providers/user_provider.dart';
import 'package:turathi/core/services/user_service.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/lib_organizer.dart';
import 'package:turathi/utils/shared.dart';
import 'package:turathi/utils/theme_manager.dart';

class DeleteUser extends StatefulWidget {
  const DeleteUser({Key? key});

  @override
  State<DeleteUser> createState() => _DeleteUser();
}

class _DeleteUser extends State<DeleteUser> {

  UserProvider userProvider=UserProvider();

  @override
  Widget build(BuildContext context) {
      print("FirebaseAuth.instance.currentUser${FirebaseAuth.instance.currentUser?.email}");
      print("object${FirebaseAuth.instance.currentUser?.uid}");
    
    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Delete User',
          style: ThemeManager.textStyle.copyWith(
            fontSize: LayoutManager.widthNHeight0(context, 1) * 0.05,
            fontWeight: FontWeight.bold,
            fontFamily: ThemeManager.fontFamily,
            color: ThemeManager.primary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Center(
              child: SizedBox(
                width: LayoutManager.widthNHeight0(context, 1) * 0.9,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: LayoutManager.widthNHeight0(context, 1) * 0.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(height: 1, color: Colors.grey[300]),
                      InkWell(
                        onTap: () async {
               

                          userProvider.deleteUserprovider();

                          //log out
                          Navigator.of(context).pushReplacementNamed(signIn);
                        },
                        child: Center(
                          child: Container(
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.3,
                            height:
                                LayoutManager.widthNHeight0(context, 0) * .06,
                            decoration: BoxDecoration(
                              color: ThemeManager.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Delete User",
                                style: TextStyle(
                                  color: ThemeManager.second,
                                  fontSize: 20,
                                  fontFamily: ThemeManager.fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
