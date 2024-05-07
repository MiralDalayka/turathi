import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/controllers/signup_controller.dart';
import 'package:turathi/core/functions/modify_data.dart';
import 'package:turathi/core/services/user_service.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/shared.dart';
import 'package:turathi/utils/theme_manager.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  bool obscureText = true; 
  SignUpController signUpController = SignUpController();
  UserService userService = UserService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    oldPassController.dispose();
    newPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Change Password',
          style: ThemeManager.textStyle.copyWith(
            fontSize: LayoutManager.widthNHeight0(context, 1) * 0.05,
            fontWeight: FontWeight.bold,
            fontFamily: ThemeManager.fontFamily,
            color: ThemeManager.primary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
              LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: Form(
        key: signUpController.formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Center(
              child: SizedBox(
                width: LayoutManager.widthNHeight0(context, 1) * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(height: 1, color: Colors.grey[300]),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        'Old Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: ThemeManager.fontFamily,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: oldPassController,
                      obscureText: obscureText,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Pass must not be empty';
                        }
                        if (value.length < 7) {
                          return "Password length should be more than 7 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        counterText: "",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ThemeManager.primary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ThemeManager.primary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        isDense: true,
                        hintText: 'Enter your current pass',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: Icon(
                         
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        'New Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: ThemeManager.fontFamily,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: newPassController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'New Pass must not be empty';
                        }
                        if (value.length < 7) {
                          return "New Password length should be more than 7 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        counterText: "",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ThemeManager.primary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ThemeManager.primary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        isDense: true,
                        hintText: 'Enter your new pass',
                      ),
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.05,
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.085,
                    ),
                    InkWell(
                      onTap: () async {
                        if (signUpController.formKey.currentState!.validate()) {
                          if ((Crypt(sharedUser.password.toString())
                              .match(oldPassController.text))) {
                            sharedUser.password =
                                hashPassword(newPassController.text);

                            userService.updateUserPass(
                                sharedUser.id.toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "User Password Updated Successfully"),
                              ),
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Old Password doesn't match"),
                              ),
                            );
                          }
                        }
                      },
                      child: Center(
                        child: Container(
                          width: LayoutManager.widthNHeight0(context, 0) * 0.3,
                          height: LayoutManager.widthNHeight0(context, 0) * .06,
                          decoration: BoxDecoration(
                            color: ThemeManager.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Change Password",
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
    );
  }
}
