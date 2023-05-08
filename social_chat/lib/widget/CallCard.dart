import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/constants/social_strings.dart';

class CallCard extends StatelessWidget {
  final darkModeModel;
  const CallCard({Key? key, required this.darkModeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: darkModeModel.isDarkMode
            ? cardItemBackgroundDark
            : cardItemBackground,
        // margin: EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Row(children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Card(
                      child: Image.asset(
                          "lib/assets/images/splash_screen_image.png"),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Justinbieber",
                            style: TextStyle(),
                          ),
                          Text(
                            "Hi, how are you",
                            style: TextStyle(color: socialTextColorSecondary),
                          ),
                        ]),
                  ),
                ]),
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.asset("lib/assets/images/call_1.svg",
                    semanticsLabel: 'Call 1'),
              )
              // const Text(
              //   "7:30 PM",
              //   style: TextStyle(
              //     color: socialTextColorSecondary,
              //     fontSize: textSizeXSmall,
              //   ),
              // ),
            ],
          ),
        ));
  }
}
