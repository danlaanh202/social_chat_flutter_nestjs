import 'package:flutter/material.dart';
import 'package:social_chat/models/DarkModeModel.dart';

class ChatScreen extends StatefulWidget {
  final DarkModeModel darkModeModel;
  const ChatScreen({Key? key, required this.darkModeModel}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        primary: false,
        shrinkWrap: true,
        children: [
          ChatItem(
            darkModeModel: widget.darkModeModel,
            isRecipient: true,
          ),
          ChatItem(
            darkModeModel: widget.darkModeModel,
            isRecipient: false,
          ),
          ChatItem(
            darkModeModel: widget.darkModeModel,
            isRecipient: true,
          ),
          ChatItem(
            darkModeModel: widget.darkModeModel,
            isRecipient: true,
          ),
          ChatItem(
            darkModeModel: widget.darkModeModel,
            isRecipient: true,
          ),
          ChatItem(
            darkModeModel: widget.darkModeModel,
            isRecipient: true,
          ),
          ChatItem(
            darkModeModel: widget.darkModeModel,
            isRecipient: false,
          ),
          ChatItem(
            darkModeModel: widget.darkModeModel,
            isRecipient: false,
          ),
          ChatItem(
            darkModeModel: widget.darkModeModel,
            isRecipient: true,
          ),
          ChatItem(
            darkModeModel: widget.darkModeModel,
            isRecipient: true,
          ),
        ],
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final DarkModeModel darkModeModel;
  final bool isRecipient;
  const ChatItem(
      {Key? key, required this.darkModeModel, required this.isRecipient})
      : super(key: key);
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
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child:
                Text("Long Text..Long Text..Long Text..Lng Text..Long Text..."),
          ),
        ),
      ],
    );
  }
}
