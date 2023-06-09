import 'package:flutter/material.dart';
import 'package:social_chat/screens/ChatRoomScreen.dart';
import 'package:social_chat/screens/UserScreen.dart';
import 'package:social_chat/services/chat_services.dart';
import 'package:social_chat/services/friend_services.dart';

class FriendOptionsBottomDialog extends StatelessWidget {
  final String? recipientId;
  final String? recipientUsername;
  final Function? removeFriend;
  const FriendOptionsBottomDialog({
    Key? key,
    required this.recipientId,
    required this.recipientUsername,
    required this.removeFriend,
  }) : super(key: key);
  void onTapToShowDialog(ctx) async {
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
        return UserScreen(userId: recipientId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      // color: Colors.amber,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                onTapToShowDialog(context);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 4)),
                overlayColor: MaterialStateProperty.resolveWith(
                  (states) {
                    return states.contains(MaterialState.pressed)
                        ? const Color.fromARGB(255, 223, 236, 247)
                        : null;
                  },
                ),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Icon(Icons.info_outline),
                  ),
                  Text(
                    "Xem tường của $recipientUsername",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ChatServices.createChat(recipientId!, "New Chat").then((data) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatRoomScreen(
                        roomId: data!,
                      ),
                    ),
                  );
                });
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 4)),
                overlayColor: MaterialStateProperty.resolveWith(
                  (states) {
                    return states.contains(MaterialState.pressed)
                        ? const Color.fromARGB(255, 223, 236, 247)
                        : null;
                  },
                ),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Icon(Icons.messenger_outlined),
                  ),
                  Text(
                    "Nhắn tin cho $recipientUsername",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FriendServices.removeFriendRequestOrFriend(
                  friendId: recipientId!,
                ).then((val) {
                  removeFriend!(recipientId);
                  Navigator.pop(context);
                });
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.only(left: 4, right: 4, bottom: 4)),
                overlayColor: MaterialStateProperty.resolveWith(
                  (states) {
                    return states.contains(MaterialState.pressed)
                        ? const Color.fromARGB(255, 223, 236, 247)
                        : null;
                  },
                ),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    "Huỷ kết bạn với $recipientUsername",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
