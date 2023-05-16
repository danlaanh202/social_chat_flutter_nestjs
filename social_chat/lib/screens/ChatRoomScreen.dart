import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat/constants/social_colors.dart';
// import 'package:social_chat/constants/social_strings.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/models/chatRoom.model.dart';
import 'package:social_chat/models/message.model.dart';
import 'package:social_chat/providers/socket.provider.dart';
import 'package:social_chat/screens/UserScreen.dart';
import 'package:social_chat/services/chat_services.dart';
import 'package:social_chat/services/message_services.dart';
import 'package:social_chat/services/shared_pref_service.dart';

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
  bool _isListening = false;
  bool _isJoin = false;
  final ScrollController _listViewController = ScrollController();
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
    _joinRoom();
    _registerMessageListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollDown();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  void _scrollDown() {
    _listViewController.animateTo(
      _listViewController.position.maxScrollExtent + 50,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _joinRoom() {
    if (!_isJoin) {
      Provider.of<SocketProvider>(context, listen: false).socket?.emit("room", {
        "chat_id": widget.roomId,
      });
      _isJoin = true;
    }
  }

  void _registerMessageListener() {
    if (!_isListening) {
      // Chỉ đăng ký lắng nghe nếu chưa đăng ký trước đó
      Provider.of<SocketProvider>(context, listen: false)
          .socket
          ?.on("message_receive_room", (data) {
        print(data);
        if (!mounted) {
          return;
        }
        setState(() {
          _messages.add(Message.fromJson(data));
        });
        _scrollDown();
      });
      _isListening = true; // Đánh dấu là đã đăng ký lắng nghe
    }
  }

  void onTapToShowDialog(ctx, {darkModeModel}) async {
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
        return UserScreen(userId: _chatRoom?.members?[0].user?.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Consumer2<DarkModeModel, SocketProvider>(
        builder: (ctx, model, socketProvider, child) {
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
                    ctx,
                    "/home",
                    (route) => false,
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: model.isDarkMode
                      ? socialPrimaryColorDark
                      : socialPrimaryColor,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onTapToShowDialog(
                      context,
                      darkModeModel:
                          Provider.of<DarkModeModel>(context, listen: false),
                    );
                  },
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
                      ),
                    ],
                  ),
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
              scrollController: _listViewController,
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
                    if (messageText != "") {
                      socketProvider.sendMessage(<String, String>{
                        "chatId": widget.roomId,
                        "content": messageText,
                      });
                    }
                    _messageController.text = "";
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
