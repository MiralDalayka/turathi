import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/controllers/login_controller.dart';
import 'package:turathi/core/models/user_model.dart';
import 'package:turathi/core/services/firebase_auth.dart';
import 'package:turathi/core/services/user_service.dart';
import 'package:turathi/utils/Router/const_router_names.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/widgets/SignFormField.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextController textController = TextController();
UserService _service=UserService();
  final FirebaseAuthService _auth = FirebaseAuthService();
  bool flag = false;

  @override
  void dispose() {
    textController.controllerEmail.dispose();
    textController.controllerPass.dispose();
    super.dispose();
  }

  bool? isChecked = false;
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    UserService _service = UserService();
    return Scaffold(
      backgroundColor: const Color(0xffEAEBEF),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
              key: textController.formField,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(150.0),
                            bottomRight: Radius.circular(150.0),
                          ),
                          child: Transform.scale(
                            scale: 1.1,
                            child: Image.asset(
                              'assets/images/img_png/profile.png',
                              width: double.infinity,
                              height: LayoutManager.widthNHeight0(context, 1) *
                                  0.54,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Positioned(
                          top: LayoutManager.widthNHeight0(context, 1) * 0.155,
                          left: LayoutManager.widthNHeight0(context, 1) * 0.08,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Turathi",
                                style: TextStyle(
                                    fontSize: LayoutManager.widthNHeight0(
                                            context, 1) *
                                        0.084,
                                    color:  ThemeManager.second,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: ThemeManager.fontFamily),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.18,
                    ),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: LayoutManager.widthNHeight0(context, 1) *
                                    0.02,
                                right: LayoutManager.widthNHeight0(context, 1) *
                                    0.6,
                                bottom:
                                    LayoutManager.widthNHeight0(context, 0) *
                                        0.02),
                          ),
                          TextFormFieldWidgetSign(
                            passToggle: false,
                            passController: textController.controllerEmail,
                            labelText: 'Email Address',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Email";
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.1#$&'*+-/=?^_ {|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);
                              if (!emailValid) {
                                return "Enter valid Email";
                              }
                              return null;
                            },
                            str: "email@gmail.com",
                          ),
                          SizedBox(
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.1,
                          ),
                          TextFormFieldWidgetSign(
                            passToggle: true,
                            passController: textController.controllerPass,
                            labelText: 'Password',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Password";
                              } else if (value.length < 7) {
                                return "Password length should be more than 7 characters";
                              } else {
                                return null;
                              }
                            },
                            str: "password",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.2,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: LayoutManager.widthNHeight0(context, 1) * 0.55,
                          height:
                              LayoutManager.widthNHeight0(context, 0) * 0.06,
                          child: InkWell(
                            onTap: () {
                              if (textController.formField.currentState!
                                  .validate()) {
                                _service.signIn(textController.controllerEmail.text,
                                    textController.controllerPass.text).whenComplete(() =>   Navigator.of(context)
                                    .pushReplacementNamed(bottomNavRoute) );
                                textController.controllerEmail.clear();
                                textController.controllerPass.clear();
                              }

                            },
                            child: Container(
                              height:
                                  LayoutManager.widthNHeight0(context, 0) * .07,
                              decoration: BoxDecoration(
                                  color: ThemeManager.primary,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: ThemeManager.second,
                                      fontSize: 20,
                                      fontFamily: ThemeManager.fontFamily,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    dynamic result = await _auth.signinAnon();
                                    if (result == null) {
                                      print('error signing in');
                                    } else {

                                      print('sign in');
                                      print(result);
                                      Navigator.of(context)
                                          .pushReplacementNamed(bottomNavRoute);

                          
                                    }
                                  },
                                  child: Text(
                                    "SignIn As Guest",
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: ThemeManager.fontFamily),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member?",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * .033,
                              fontFamily: ThemeManager.fontFamily,
                              color: Colors.grey[600]),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(signUp);
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  fontFamily: ThemeManager.fontFamily,
                                  color: Colors.grey[700]),
                            ))
                      ],
                    ),
                  ])),
        ),
      ),
    );
  }


}
