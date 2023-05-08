import 'package:flutter/material.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/models/chatRoom.model.dart';
import 'package:social_chat/services/chat_services.dart';
import 'package:social_chat/widget/ChatCard.dart';

class HomeChatScreen extends StatefulWidget {
  final DarkModeModel darkModeModel;
  const HomeChatScreen({Key? key, required this.darkModeModel})
      : super(key: key);

  @override
  _HomeChatScreenState createState() => _HomeChatScreenState();
}

class _HomeChatScreenState extends State<HomeChatScreen> {
  List<ChatRoom> _chatRooms = [];
  @override
  void initState() {
    super.initState();
    ChatServices.getChats().then((data) {
      setState(() {
        _chatRooms = data!;
      });
    });
  }

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
                child: ListView.builder(
                  itemCount: _chatRooms.length,
                  itemBuilder: (ctx, index) => ChatCard(
                    darkModeModel: widget.darkModeModel,
                    chatRoom: _chatRooms[index],
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
