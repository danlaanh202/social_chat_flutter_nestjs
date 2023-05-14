import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/constants/social_strings.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/models/chatRoom.model.dart';
import 'package:social_chat/providers/socket.provider.dart';
import 'package:social_chat/screens/ChatRoomScreen.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatefulWidget {
  final DarkModeModel darkModeModel;
  final String? myUserId;
  final ChatRoom chatRoom;
  const ChatCard({
    Key? key,
    required this.darkModeModel,
    required this.chatRoom,
    required this.myUserId,
  }) : super(key: key);

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.chatRoom.isLastMessageViewed! &&
            widget.myUserId != widget.chatRoom.messages![0].senderId!) {
          Provider.of<SocketProvider>(context, listen: false)
              .socket!
              .emit("room_seen", {
            "room_id": widget.chatRoom.id,
            "my_id": widget.myUserId,
          });
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoomScreen(
              roomId: widget.chatRoom.id!,
            ),
          ),
        );
      },
      child: Container(
          color: widget.darkModeModel.isDarkMode
              ? cardItemBackgroundDark
              : cardItemBackground,
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
                        "lib/assets/images/splash_screen_image.png",
                      )),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.chatRoom.members![0].user!.username!,
                              style: const TextStyle(),
                            ),
                            Text(
                              widget.chatRoom.messages!.isNotEmpty
                                  ? widget.chatRoom.messages![0].content!
                                  : "New Chat",
                              style: _textViewedStyle(widget.myUserId, 2),
                            ),
                          ]),
                    ),
                  ]),
                ),
                Text(
                  DateFormat('hh:mm a').format(
                    DateTime.parse(
                      widget.chatRoom.messages!.isNotEmpty
                          ? widget.chatRoom.messages![0].createdAt!
                          : widget.chatRoom.createdAt!,
                    ),
                  ),
                  style: _textViewedStyle(widget.myUserId, 1),
                )
              ],
            ),
          )),
    );
  }

  TextStyle _textViewedStyle(String? userId, int type) {
    const double fontSize = textSizeSmall;
    if (widget.chatRoom.messages!.isEmpty) {
      return const TextStyle(
        color: socialTextColorSecondary,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    }
    if (userId != widget.chatRoom.messages![0].senderId) {
      if (widget.chatRoom.isLastMessageViewed ?? true) {
        return const TextStyle(
          color: socialTextColorSecondary,
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
        );
      } else {
        return const TextStyle(
          color: socialTextColorPrimary,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        );
      }
    } else {
      return const TextStyle(
        color: socialTextColorSecondary,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      );
    }
  }
}
