import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/constants/social_strings.dart';
import 'package:social_chat/models/ActiveNavmodel.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/widget/SwitchDarkMode.dart';

class ChoosenBar extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final activeNavModel;
  final DarkModeModel darkModeModel;
  const ChoosenBar({
    Key? key,
    required this.darkModeModel,
    required this.activeNavModel,
  }) : super(key: key);
  // void onTap(int index, ActiveNavModel model) {
  //   model.setActiveNav(index);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: BarItem(
                title: "Chats",
                barActive: activeNavModel.activeNav == 0,
                darkModeModel: darkModeModel,
                onTap: () {
                  activeNavModel.setActiveNav(0);
                }),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(
              color: darkModeModel.isDarkMode ? dividerColorDark : dividerColor,
              width: .5,
            )),
          ),
          Expanded(
              child: BarItem(
                  title: "Status",
                  barActive: activeNavModel.activeNav == 1,
                  darkModeModel: darkModeModel,
                  onTap: () {
                    activeNavModel.setActiveNav(1);
                  })),
          Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(
              color: darkModeModel.isDarkMode ? dividerColorDark : dividerColor,
              width: .5,
            )),
          ),
          Expanded(
            child: BarItem(
                title: "Calls",
                barActive: activeNavModel.activeNav == 2,
                darkModeModel: darkModeModel,
                onTap: () {
                  activeNavModel.setActiveNav(2);
                }),
          ),
          // SwitchDarkMode()
        ],
      ),
    );
  }
}

class BarItem extends StatelessWidget {
  final String title;
  final bool barActive;
  final Function onTap;
  final DarkModeModel darkModeModel;
  const BarItem({
    Key? key,
    required this.title,
    this.barActive = false,
    required this.onTap,
    required this.darkModeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: darkModeModel.isDarkMode
            ? cardItemBackgroundDark
            : cardItemBackground,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: textSizeSmall,
              fontWeight: barActive ? FontWeight.bold : FontWeight.normal,
              color: (darkModeModel.isDarkMode)
                  ? (barActive ? Colors.white : Colors.grey)
                  : (barActive
                      ? socialTextColorPrimary
                      : socialTextColorSecondary),
            ),
          ),
        ),
      ),
    );
  }
}
