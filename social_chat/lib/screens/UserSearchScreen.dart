import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/models/friend.model.dart';
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
  final _searchController = TextEditingController();
  String _searchQuery = '';
  List<Friend> _users = [];
  @override
  void initState() {
    super.initState();
    _searchQuery = _searchController.text;
    FriendServices.searchUsers(searchQuery: "").then((data) {
      setState(() {
        _users = data;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _searchController.addListener(() {
      if (_searchController.text != _searchQuery) {
        setState(() {
          _searchQuery = _searchController.text;
          FriendServices.searchUsers(searchQuery: _searchController.text)
              .then((data) {
            _users = data;
          });
        });
      }
    });
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
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.resolveWith(
                      (states) {
                        return states.contains(MaterialState.pressed)
                            ? Color.fromARGB(255, 223, 236, 247)
                            : null;
                      },
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: const Text(
                    "All",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.resolveWith(
                      (states) {
                        return states.contains(MaterialState.pressed)
                            ? Color.fromARGB(255, 223, 236, 247)
                            : null;
                      },
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: const Text(
                    "Sent requests",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Thực hiện một hành động nào đó khi button được chạm vào
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    overlayColor: MaterialStateProperty.resolveWith(
                      (states) {
                        return states.contains(MaterialState.pressed)
                            ? Color.fromARGB(255, 87, 182, 250)
                            : null;
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  child: Text('Received requests'),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _users.length,
                itemBuilder: (ctx, index) {
                  return SearchUserItem(
                      username: _users[index].username,
                      status: _users[index].friendStatus);
                }),
          )
        ],
      ),
    );
  }
}

class SearchUserItem extends StatelessWidget {
  final String? username;
  final String? status;
  const SearchUserItem({Key? key, required this.username, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, right: 16, left: 16),
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
                  username!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            child: Text(
              // "Add friend",
              status!,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
