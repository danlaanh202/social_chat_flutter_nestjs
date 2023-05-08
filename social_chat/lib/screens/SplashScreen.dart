import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:lottie/lottie.dart';
import 'package:social_chat/screens/LoginScreen.dart';
import 'package:social_chat/widget/MyNextButtonFullScreen.dart';
import 'package:social_chat/widget/SwitchDarkMode.dart';
import "package:social_chat/constants/social_strings.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        const Positioned(top: 44, right: 20, child: SwitchDarkMode()),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                "Welcome to Social Plus",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: textSizeNormal),
              ),
            ),
            Lottie.asset('lib/assets/images/social.json',
                height: width * 0.7, width: double.infinity),
            // SizedBox(
            //   width: 260,
            //   child: Image.asset("lib/assets/images/splash_screen_image.png"),
            // ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Text(
                "Read our Privacy Policy. Tap Agree and Continue to accept the Terms of Services",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: MyNextButtonFullScreen(
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
                buttonText: "Agree & Continue",
              ),
            )
          ],
        ),
      ],
    ));
  }
}
