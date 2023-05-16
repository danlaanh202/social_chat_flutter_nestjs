import 'package:flutter/material.dart';
import 'package:social_chat/constants/social_strings.dart';
import 'package:social_chat/models/status.model.dart';
import 'package:social_chat/screens/UserScreen.dart';

class StatusItem extends StatefulWidget {
  final Status? statusItem;
  const StatusItem({Key? key, required this.statusItem}) : super(key: key);

  @override
  _StatusItemState createState() => _StatusItemState();
}

class _StatusItemState extends State<StatusItem> {
  void onTapToShowDialog() async {
    showGeneralDialog(
      context: context,
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
        return UserScreen(userId: widget.statusItem!.author!.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: GestureDetector(
            onTap: () {
              onTapToShowDialog();
            },
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: const SizedBox(
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        "lib/assets/images/splash_screen_image.png",
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.statusItem!.author!.username!,
                  style: const TextStyle(fontSize: textSizeLargeMedium),
                )
              ],
            ),
          ),
        ),
        widget.statusItem!.description != ""
            ? Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
                child: Text(
                  widget.statusItem!.description!,
                ),
              )
            : Container(),
        Image.network(
          "https://res.cloudinary.com/dantranne/image/upload/v1684153729/file_flxejk.jpg",
        ),
      ],
    );
  }
}
