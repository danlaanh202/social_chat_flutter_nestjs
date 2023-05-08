import 'package:flutter/material.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/widget/setting_screen/SettingCard.dart';
import 'package:social_chat/widget/settings_dialog/SettingDetailDialog.dart';

class SettingScreenUI extends StatefulWidget {
  final DarkModeModel darkModeModel;
  const SettingScreenUI({
    Key? key,
    required this.darkModeModel,
  }) : super(key: key);
  void toggleSwitchDarkMode(val) {
    darkModeModel.toggleTheme();
  }

  @override
  _SettingScreenUIState createState() => _SettingScreenUIState();
}

class _SettingScreenUIState extends State<SettingScreenUI> {
  void onTapToShowDialog(ctx, {darkModeModel, typeIndex}) {
    showGeneralDialog(
      context: ctx,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SettingDetailDialog(
          darkModeModel: widget.darkModeModel,
          type: typeIndex,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: cardItemBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          SettingCard(
                            darkModeModel: widget.darkModeModel,
                            cardTitle: "DarkMode",
                            hasSwitch: true,
                            toggleSwitch: widget.toggleSwitchDarkMode,
                            cardIcon: Icons.dark_mode_outlined,
                            onTap: () {
                              widget.toggleSwitchDarkMode(true);
                            },
                          ),
                          SettingCard(
                            darkModeModel: widget.darkModeModel,
                            cardTitle: "Account",
                            subTitle: "Privacy, security, change number",
                            cardIcon: Icons.key,
                            onTap: () {
                              onTapToShowDialog(
                                context,
                                darkModeModel: widget.darkModeModel,
                                typeIndex: 0,
                              );
                            },
                          ),
                          SettingCard(
                              darkModeModel: widget.darkModeModel,
                              cardTitle: "Chats",
                              subTitle: "Backup, history, wallpaper",
                              cardIcon: Icons.message,
                              onTap: () {
                                onTapToShowDialog(
                                  context,
                                  darkModeModel: widget.darkModeModel,
                                  typeIndex: 1,
                                );
                              }),
                          SettingCard(
                            darkModeModel: widget.darkModeModel,
                            cardTitle: "Data and storage usage",
                            subTitle: "Network usage, auto download",
                            cardIcon: Icons.private_connectivity,
                            onTap: () {
                              onTapToShowDialog(
                                context,
                                darkModeModel: widget.darkModeModel,
                                typeIndex: 2,
                              );
                            },
                          ),
                          SettingCard(
                            darkModeModel: widget.darkModeModel,
                            cardTitle: "Notifications",
                            subTitle: "Message, group & call tones",
                            cardIcon: Icons.notifications,
                            onTap: () {
                              onTapToShowDialog(
                                context,
                                darkModeModel: widget.darkModeModel,
                                typeIndex: 3,
                              );
                            },
                          ),
                          SettingCard(
                            darkModeModel: widget.darkModeModel,
                            cardTitle: "Help",
                            subTitle: "FAQ, contact us, privacy policy",
                            cardIcon: Icons.help,
                            onTap: () {
                              onTapToShowDialog(
                                context,
                                darkModeModel: widget.darkModeModel,
                                typeIndex: 4,
                              );
                            },
                          ),
                        ],
                      )))),
        ],
      ),
    ));
  }
}
