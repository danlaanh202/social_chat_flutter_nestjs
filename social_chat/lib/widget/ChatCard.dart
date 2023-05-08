import 'package:flutter/material.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/constants/social_strings.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/models/chatRoom.model.dart';
import 'package:social_chat/screens/ChatRoomScreen.dart';

class ChatCard extends StatelessWidget {
  final DarkModeModel darkModeModel;

  final ChatRoom chatRoom;
  const ChatCard(
      {Key? key, required this.darkModeModel, required this.chatRoom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatRoomScreen(roomId: chatRoom.id!)),
        );
      },
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
                          child: Image.asset(
                              "lib/assets/images/splash_screen_image.png")),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chatRoom.members![0].user!.username!,
                              style: const TextStyle(),
                            ),
                            const Text(
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
          )),
    );
  }
}
