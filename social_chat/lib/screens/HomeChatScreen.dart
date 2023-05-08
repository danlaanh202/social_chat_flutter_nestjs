import 'package:flutter/material.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/widget/ChatCard.dart';

class HomeChatScreen extends StatefulWidget {
  final DarkModeModel darkModeModel;
  const HomeChatScreen({Key? key, required this.darkModeModel})
      : super(key: key);

  @override
  _HomeChatScreenState createState() => _HomeChatScreenState();
}

class _HomeChatScreenState extends State<HomeChatScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: const Text("Chats list"),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
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
                      ChatCard(
                        chatRoomId: "444",
                        darkModeModel: widget.darkModeModel,
                      ),
                      ChatCard(
                        chatRoomId: "443",
                        darkModeModel: widget.darkModeModel,
                      ),
                      ChatCard(
                        chatRoomId: "442",
                        darkModeModel: widget.darkModeModel,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
