import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat/constants/social_colors.dart';
// import 'package:social_chat/constants/social_strings.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/models/chatRoom.model.dart';
import 'package:social_chat/models/message.model.dart';
import 'package:social_chat/providers/socket.provider.dart';
import 'package:social_chat/services/chat_services.dart';
import 'package:social_chat/services/message_services.dart';

// import 'package:social_chat/widget/MySquareButton.dart';
import 'package:social_chat/widget/chat_list/ChatScreen.dart';

class ChatRoomScreen extends StatefulWidget {
  final String roomId;
  const ChatRoomScreen({Key? key, required this.roomId}) : super(key: key);
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  ChatRoom? _chatRoom;
  List<Message?> _messages = [];
  final _messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    ChatServices.getChatRoom(widget.roomId).then((value) {
      setState(() {
        _chatRoom = value;
      });
    });
    MessageServices.getMessages(widget.roomId).then((val) {
      setState(() {
        _messages = val;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Consumer2<DarkModeModel, SocketProvider>(
        builder: (context, model, socketProvider, child) {
      socketProvider.socket?.on("receive_message", (data) {
        if (!mounted) {
          return;
        }
        setState(() {
          _messages.add(Message.fromJson(data));
        });
      });
      return Scaffold(
        appBar: AppBar(
          titleSpacing: 8,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/home", (route) => false);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: model.isDarkMode
                      ? socialPrimaryColorDark
                      : socialPrimaryColor,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      margin: const EdgeInsets.only(
                        right: 12,
                      ),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "lib/assets/images/splash_screen_image.png",
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _chatRoom?.members?[0].user?.username ??
                                "Recipient",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: model.isDarkMode
                                  ? Colors.white
                                  : socialTextColorPrimary,
                            ),
                          ),
                          Text(
                            "subtitle",
                            style: TextStyle(
                              color: model.isDarkMode
                                  ? Colors.white
                                  : socialTextColorPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.call,
                      color: model.isDarkMode
                          ? socialPrimaryColorDark
                          : socialPrimaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.video_call_rounded,
                      color: model.isDarkMode
                          ? socialPrimaryColorDark
                          : socialPrimaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.info,
                      color: model.isDarkMode
                          ? socialPrimaryColorDark
                          : socialPrimaryColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChatScreen(
              darkModeModel: model,
              messages: _messages,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                ),
                Expanded(
                    child: SizedBox(
                  child: TextField(
                    controller: _messageController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 6,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      hintText: "Nhắn tin",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      filled: true,
                      fillColor: Colors.white24,
                    ),
                  ),
                )),
                IconButton(
                  onPressed: () {
                    String messageText = _messageController.text;
                    _messageController.text = "";
                    if (messageText != "") {
                      socketProvider.sendMessage({
                        "chatId": widget.roomId,
                        "content": messageText,
                      });
                      // MessageServices.createMessage(
                      //   widget.roomId,
                      //   messageText,
                      // ).then((val) {
                      //   setState(() {
                      //     _messages.add(val);
                      //   });
                      // });
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    size: 24,
                    color: model.isDarkMode
                        ? socialPrimaryColorDark
                        : socialPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
