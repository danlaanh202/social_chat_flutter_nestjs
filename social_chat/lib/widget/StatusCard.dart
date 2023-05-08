import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_chat/constants/dashed_circle.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/constants/social_strings.dart';

class StatusCard extends StatelessWidget {
  final darkModeModel;
  const StatusCard({Key? key, required this.darkModeModel}) : super(key: key);

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
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: DashedCircle(
                          dashes: 8,
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(
                              'lib/assets/images/splash_screen_image.png',
                            ),
                          ),
                        ),
                      )),
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
                            "30 minutes ago",
                            style: TextStyle(color: socialTextColorSecondary),
                          ),
                        ]),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}
