import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/constants/social_strings.dart';
import 'package:social_chat/models/ActiveNavmodel.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/services/auth_services.dart';
import 'package:social_chat/widget/MySquareButton.dart';
import 'package:social_chat/widget/setting_screen/SettingScreenUI.dart';

class SettingsScreen extends StatefulWidget {
  final activeNavModel;
  final DarkModeModel darkModeModel;

  const SettingsScreen(
      {Key? key, required this.darkModeModel, required this.activeNavModel})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: widget.darkModeModel.isDarkMode
          ? socialBrightnessLight
          : socialBrightnessDark,
    ));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: MySquareButton(
                    width: 36,
                    height: 36,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
              Text(
                "SETTINGS",
                style: TextStyle(
                  color: widget.darkModeModel.isDarkMode
                      ? Colors.white
                      : socialTextColorPrimary,
                  fontSize: textSizeMedium,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: MySquareButton(
                  width: 36,
                  height: 36,
                  iconSize: 24,
                  buttonIcon: Icons.logout_rounded,
                  buttonColor: Colors.grey[300],
                  iconColor: Colors.black,
                  onPressed: () {
                    AuthServices.logout();
                    Navigator.pushNamed(context, "/login");
                  },
                ),
              ),
            ],
          ),
        ),
        backgroundColor: widget.darkModeModel.isDarkMode
            ? darkModeAppbarBackground
            : socialScaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingScreenUI(
            darkModeModel: widget.darkModeModel,
          ),
        ],
      ),
    );
  }
}
