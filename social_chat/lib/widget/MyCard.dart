import 'package:flutter/material.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/constants/social_strings.dart';

class MyCard extends StatelessWidget {
  final darkModeModel;
  const MyCard({Key? key, required this.darkModeModel}) : super(key: key);

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
                      clipBehavior: Clip.hardEdge,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 0,
                              right: 0,
                              bottom: 0,
                              left: 0,
                              child: Image.asset(
                                  "lib/assets/images/splash_screen_image.png")),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: socialPrimaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                  ),
                                ),
                                width: 16,
                                height: 16,
                                child: const Center(
                                    child: Icon(
                                  Icons.add,
                                  size: 14,
                                  color: Colors.white,
                                )),
                              ))
                        ],
                      ),
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
              const Text(
                "7:30 PM",
                style: TextStyle(
                  color: socialTextColorSecondary,
                  fontSize: textSizeXSmall,
                ),
              ),
            ],
          ),
        ));
  }
}
