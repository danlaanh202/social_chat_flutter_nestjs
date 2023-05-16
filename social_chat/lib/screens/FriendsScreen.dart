import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_chat/models/friend.model.dart';
import 'package:social_chat/screens/UserSearchScreen.dart';
import 'package:social_chat/services/auth_services.dart';
import 'package:social_chat/services/debounce.dart';
import 'package:social_chat/services/friend_services.dart';
import 'package:social_chat/services/shared_pref_service.dart';
import 'package:social_chat/widget/FriendOptionsBottomDialog.dart';
import 'package:social_chat/widget/settings_dialog/SettingDetailDialog.dart';

import '../constants/social_colors.dart';
import '../constants/social_strings.dart';
import '../models/DarkModeModel.dart';
import '../widget/MySquareButton.dart';

void onTapToShowDialog(ctx, {darkModeModel}) {
  showGeneralDialog(
    context: ctx,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return UserSearchScreen(
        darkModeModel: darkModeModel,
      );
    },
  );
}

class FriendsScreen extends StatefulWidget {
  final DarkModeModel darkModeModel;
  const FriendsScreen({
    Key? key,
    required this.darkModeModel,
  }) : super(key: key);

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  List<Friend> _friends = [];
  int _count = 0;
  final _searchController = TextEditingController();
  static final Debouncer debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _callApiFriend("");
    _searchController.addListener(_onSearchQueryChanged);
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
              Text(
                "cec",
                style: TextStyle(
                  fontSize: textSizeMedium,
                  color: widget.darkModeModel.isDarkMode
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: MySquareButton(
                  width: 36,
                  height: 36,
                  iconSize: 24,
                  buttonIcon: Icons.search,
                  buttonColor: Colors.grey[300],
                  iconColor: Colors.black,
                  onPressed: () {
                    onTapToShowDialog(context,
                        darkModeModel: widget.darkModeModel);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: "Search friends",
                  hintStyle: const TextStyle(fontSize: 14),
                  contentPadding: const EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  prefixIcon: const Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "$_count friends",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: _friends.length,
                    itemBuilder: (ctx, index) {
                      return FriendItem(
                        username: _friends[index].username,
                        friendId: _friends[index].id,
                        removeFriend: _removeFriend,
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onSearchQueryChanged() {
    debouncer.run(() {
      _callApiFriend(_searchController.text);
    });
  }

  _callApiFriend(String searchQuery) async {
    await FriendServices.searchFriends(searchQuery: searchQuery).then((data) {
      setState(() {
        _friends = data!;
      });
    });
  }

  _removeFriend(String friendId) {
    setState(() {
      _friends.removeWhere((element) => element.id == friendId);
    });
  }
}

class FriendItem extends StatelessWidget {
  final String? username;
  final String? friendId;
  final dynamic removeFriend;
  const FriendItem({
    Key? key,
    required this.username,
    required this.friendId,
    required this.removeFriend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: const CircleAvatar(
              backgroundImage: AssetImage(
                "lib/assets/images/splash_screen_image.png",
              ),
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          )),
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) => FriendOptionsBottomDialog(
                  recipientId: friendId,
                  recipientUsername: username,
                  removeFriend: removeFriend,
                ),
              );
            },
            splashRadius: 20,
            icon: const Icon(Icons.more_horiz),
          )
        ],
      ),
    );
  }
}
