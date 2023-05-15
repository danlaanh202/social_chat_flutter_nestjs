import 'package:flutter/material.dart';
import 'package:social_chat/constants/list_dialog.dart';
import 'package:social_chat/constants/social_strings.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/widget/MySquareButton.dart';

class SettingDetailDialog extends StatelessWidget {
  final DarkModeModel darkModeModel;
  int type;
  SettingDetailDialog({
    Key? key,
    required this.darkModeModel,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MySquareButton(
                width: 36,
                height: 36,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                dialogList[type].title,
                style: TextStyle(
                  fontSize: textSizeMedium,
                  color: darkModeModel.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(
                width: 36,
                height: 36,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          dialogList[type].dialogBody,
        ],
      ),
    );
  }
}
