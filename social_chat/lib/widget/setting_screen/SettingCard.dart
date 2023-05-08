import 'package:flutter/material.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/constants/social_strings.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/widget/CustomSwitch.dart';

class SettingCard extends StatelessWidget {
  final DarkModeModel darkModeModel;
  final String cardTitle;
  final String? subTitle;
  bool? hasSwitch;
  final toggleSwitch;
  final IconData cardIcon;
  final onTap;
  SettingCard({
    Key? key,
    required this.darkModeModel,
    required this.cardTitle,
    this.subTitle,
    this.hasSwitch = false,
    this.toggleSwitch,
    required this.cardIcon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: cardWithIconBackground,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              bottom: 0,
                              left: 0,
                              child: Icon(
                                cardIcon,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cardTitle,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subTitle?.isNotEmpty ?? false
                                ? Text(
                                    "$subTitle",
                                    style: const TextStyle(
                                        color: socialTextColorSecondary),
                                  )
                                : const SizedBox.shrink(),
                          ]),
                    ),
                  ]),
                ),
                hasSwitch!
                    ? CustomSwitch(
                        isOn: darkModeModel.isDarkMode,
                        toggleSwitch: (val) => toggleSwitch(val),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          )),
    );
  }
}
