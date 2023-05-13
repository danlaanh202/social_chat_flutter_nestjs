import 'package:flutter/material.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/models/message.model.dart';
import 'package:social_chat/services/shared_pref_service.dart';

class ChatScreen extends StatefulWidget {
  final DarkModeModel darkModeModel;
  final List<Message?> messages;

  const ChatScreen(
      {Key? key, required this.darkModeModel, required this.messages})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? _myUserId = "";

  @override
  void initState() {
    super.initState();
    _getMyId().then((val) {
      _myUserId = val;
    });
  }

  Future<String?> _getMyId() async {
    String? userId = await SharedPreferencesServices.getData("userId");
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.messages.length,
        itemBuilder: (ctx, index) => ChatItem(
          darkModeModel: widget.darkModeModel,
          isRecipient: _myUserId != widget.messages[index]?.senderId,
          message: widget.messages[index]!,
        ),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final DarkModeModel darkModeModel;
  final bool isRecipient;
  final Message message;
  const ChatItem({
    Key? key,
    required this.darkModeModel,
    required this.isRecipient,
    required this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment:
          isRecipient ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        isRecipient
            ? Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.symmetric(horizontal: 12),
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
              )
            : const SizedBox(),
        Container(
          margin: EdgeInsets.symmetric(
              vertical: 12, horizontal: isRecipient ? 0 : 12),
          constraints: BoxConstraints(
            maxWidth: width * 68 / 100,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.lightBlue,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Text(
              message.content!,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
