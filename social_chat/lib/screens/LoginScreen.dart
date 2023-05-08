import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_chat/constants/social_strings.dart';
import 'package:social_chat/models/auth.model.dart';
import 'package:social_chat/screens/HomeScreen.dart';
import 'package:social_chat/screens/RegisterScreen.dart';
import 'package:social_chat/screens/SplashScreen.dart';
import 'package:social_chat/services/auth_services.dart';
import 'package:social_chat/services/shared_pref_service.dart';
import 'package:social_chat/widget/MyNextButtonFullScreen.dart';
import 'package:social_chat/widget/MySquareButton.dart';
import 'package:social_chat/widget/SwitchDarkMode.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: 44,
          left: 0,
          right: 0,
          child: SizedBox(
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  // MySquareButton(
                  //   width: 36,
                  //   height: 36,
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
                  SwitchDarkMode(),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 128,
            left: 0,
            right: 0,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text("Welcome",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: textSizeNormal,
                          )),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "Enter your username and password to continue to Social Plus Messenger and enjoy messaging and calling to all your friend",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: textSizeSmall,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: "Username",
                          hintText: "Enter your username",
                        )),
                    TextField(
                        controller: _passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          hintText: "Enter your password",
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 28, bottom: 12),
                      child: MyNextButtonFullScreen(
                          onPressed: () async {
                            await AuthServices.login(_usernameController.text,
                                    _passwordController.text)
                                .then((res) {
                              Navigator.pushNamed(context, "/home");
                            });
                          },
                          buttonText: "Continue"),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/register");
                        },
                        child: const Text(
                          "Create new account",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ))),
      ],
    ));
  }
}
