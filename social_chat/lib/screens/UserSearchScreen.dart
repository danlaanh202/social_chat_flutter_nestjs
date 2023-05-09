import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/models/friend.model.dart';
import 'package:social_chat/models/friend_request.model.dart';
import 'package:social_chat/services/debounce.dart';
import 'package:social_chat/services/friend_services.dart';
import 'package:social_chat/widget/MySquareButton.dart';

class UserSearchScreen extends StatefulWidget {
  final DarkModeModel darkModeModel;
  const UserSearchScreen({Key? key, required this.darkModeModel})
      : super(key: key);

  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  List<Friend> _users = [];
  int _typeIndex = 0;
  final _searchController = TextEditingController();
  static final Debouncer debouncer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    _callApiUsers("");
    _searchController.addListener(_onSearchQueryChanged);
  }

  _callApiUsers(String searchQuery) {
    FriendServices.searchUsers(searchQuery: searchQuery, typeIndex: _typeIndex)
        .then((data) {
      setState(() {
        _users = data;
      });
    });
  }

  _onSearchQueryChanged() {
    debouncer.run(() {
      _callApiUsers(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchQueryChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: widget.darkModeModel.isDarkMode
          ? socialBrightnessLight
          : socialBrightnessDark,
    ));
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 8,
          title: SizedBox(
            width: width,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: MySquareButton(
                        width: 36,
                        height: 36,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search username",
                        hintStyle: const TextStyle(fontSize: 14),
                        contentPadding: const EdgeInsets.all(8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ))
                ]),
          )),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _typeIndex = 0;
                        _callApiUsers(_searchController.text);
                      });
                    },
                    style: _buttonStyle(0),
                    child: Text(
                      "All",
                      style: _textStyle(0),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _typeIndex = 1;
                        _callApiUsers(_searchController.text);
                      });
                    },
                    style: _buttonStyle(1),
                    child: Text(
                      "Sent requests",
                      style: _textStyle(1),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _typeIndex = 2;
                        _callApiUsers(_searchController.text);
                      });
                    },
                    style: _buttonStyle(2),
                    child: Text(
                      'Received requests',
                      style: _textStyle(2),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _users.length,
                itemBuilder: (ctx, index) {
                  return SearchUserItem(
                    user: _users[index],
                    handleButton: (String friendStatus_, String userId) {
                      _handleButton(friendStatus_, userId, index);
                    },
                  );
                }),
          )
        ],
      ),
    );
  }

  Future<void> _handleButton(
      String friendStatus, String friendId, int friendIndex) async {
    if (friendStatus == "FRIEND") {
      await FriendServices.removeFriendRequestOrFriend(friendId: friendId);

      setState(() {
        _users[friendIndex].friendStatus = "NO_STATUS";
      });
      // REMOVE
    } else if (friendStatus == "SENT") {
      await FriendServices.removeFriendRequestOrFriend(friendId: friendId);

      setState(() {
        _users[friendIndex].friendStatus = "NO_STATUS";
      });
      // REVOKE
    } else if (friendStatus == "RECEIVED") {
      await FriendServices.acceptFriendRequestByUserIds(requesterId: friendId);

      setState(() {
        _users[friendIndex].friendStatus = "FRIEND";
      });

      // REJECT
      // ACCEPT
    } else if (friendStatus == "NO_STATUS") {
      await FriendServices.sendFriendRequestByUserIds(recipientId: friendId);

      setState(() {
        _users[friendIndex].friendStatus = "SENT";
      });

      // SEND
    }
  }

  TextStyle _textStyle(int id) {
    if (_typeIndex == id) {
      return const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    } else {
      return const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );
    }
  }

  ButtonStyle _buttonStyle(int id) {
    if (_typeIndex == id) {
      return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.pressed)
                ? const Color.fromARGB(255, 87, 182, 250)
                : null;
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.blue),
          ),
        ),
      );
    } else {
      return ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.blue),
          ),
        ),
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.pressed)
                ? const Color.fromARGB(255, 223, 236, 247)
                : null;
          },
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
      );
    }
  }
}

class SearchUserItem extends StatelessWidget {
  final Friend user;
  final Function(String friendStatus, String userId) handleButton;
  const SearchUserItem(
      {Key? key, required this.user, required this.handleButton})
      : super(key: key);

  String _friendStatusText(String friendStatus) {
    switch (friendStatus) {
      case "FRIEND":
        return "Remove Friend";
      case "NO_STATUS":
        return "Send request";
      case "RECEIVED":
        return "Accept Request";
      case "SENT":
        return "Revoke Sent";

      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, right: 16, left: 16),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.only(right: 12),
              child: const CircleAvatar(
                backgroundImage:
                    AssetImage("lib/assets/images/splash_screen_image.png"),
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              handleButton(user.friendStatus!, user.id!);
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            child: Text(
              // "Add friend",
              _friendStatusText(user.friendStatus!),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
