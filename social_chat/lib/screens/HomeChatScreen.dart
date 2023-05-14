import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/models/chatRoom.model.dart';
import 'package:social_chat/models/message.model.dart';
import 'package:social_chat/services/chat_services.dart';
import 'package:social_chat/services/shared_pref_service.dart';
import 'package:social_chat/widget/ChatCard.dart';

import '../providers/socket.provider.dart';

class HomeChatScreen extends StatefulWidget {
  final DarkModeModel darkModeModel;
  const HomeChatScreen({Key? key, required this.darkModeModel})
      : super(key: key);

  @override
  _HomeChatScreenState createState() => _HomeChatScreenState();
}

class _HomeChatScreenState extends State<HomeChatScreen> {
  List<ChatRoom> _chatRooms = [];
  String? _myUserId;
  @override
  void initState() {
    super.initState();

    _registerUpdateLastMessage();
    _registerUpdateSeenLastMessage();
    SharedPreferencesServices.getData("userId").then((userId) {
      setState(() {
        _myUserId = userId;
      });
    });
    ChatServices.getChats().then((data) {
      setState(() {
        _chatRooms = data!;
      });
    });
  }

  _handleReceiveMessage(data) {
    if (!mounted) {
      return;
    }
    for (var chatRoom in _chatRooms) {
      if (chatRoom.id == data["chat_id"]) {
        setState(() {
          chatRoom.isLastMessageViewed = false;
          chatRoom.messages![0] = Message.fromJson(data);
        });
        break;
      }
    }
  }

  _registerUpdateLastMessage() {
    Provider.of<SocketProvider>(context, listen: false)
        .socket!
        .on("message_receive", _handleReceiveMessage);
  }

  _registerUpdateSeenLastMessage() {
    Provider.of<SocketProvider>(context, listen: false)
        .socket!
        .on("room_seen_receive", (data) {
      if (!mounted) {
        return;
      }
      for (var chatRoom in _chatRooms) {
        if (chatRoom.id == data["chat_id"]) {
          setState(() {
            chatRoom.isLastMessageViewed = true;
          });
          break;
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
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
                  color: widget.darkModeModel.isDarkMode
                      ? cardItemBackgroundDark
                      : cardItemBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: _chatRooms.length,
                  itemBuilder: (ctx, index) => ChatCard(
                    darkModeModel: widget.darkModeModel,
                    chatRoom: _chatRooms[index],
                    myUserId: _myUserId,
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
