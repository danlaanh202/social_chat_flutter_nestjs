// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/constants/social_strings.dart';
import 'package:social_chat/providers/socket.provider.dart';
import 'package:social_chat/screens/FriendsScreen.dart';
import 'package:social_chat/screens/HomeCallScreen.dart';
import 'package:social_chat/screens/HomeChatScreen.dart';
import 'package:social_chat/screens/HomeStatusScreen.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:social_chat/screens/SettingsScreen.dart';
import 'package:social_chat/screens/UserScreen.dart';
import 'package:social_chat/services/shared_pref_service.dart';
import 'package:social_chat/widget/ChoosenBar.dart';

import 'package:social_chat/widget/MySquareButton.dart';
import 'package:social_chat/widget/settings_dialog/SettingDetailDialog.dart';

import '../models/DarkModeModel.dart';
import '../models/ActiveNavModel.dart';
import '../widget/status/CreateStatusDialog.dart';

Widget _getCurrentScreen(int activeNavIndex, darkModeModel, activeNavModel) {
  switch (activeNavIndex) {
    case 0:
      return HomeChatScreen(darkModeModel: darkModeModel);
    case 1:
      return HomeStatusScreen(darkModeModel: darkModeModel);
    case 2:
      return HomeCallScreen(darkModeModel: darkModeModel);
    default:
      return HomeChatScreen(darkModeModel: darkModeModel);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String _textTitle(int activeNavIndex) {
    switch (activeNavIndex) {
      case 0:
        return "Chats";
      case 1:
        return "Status";
      case 2:
        return "Calls";
      default:
        return "Chats";
    }
  }

  Animation<double>? _animation;
  AnimationController? _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    _handleConnectSocket();
    super.initState();
  }

  _handleConnectSocket() {
    Provider.of<SocketProvider>(context, listen: false).connect();
  }

  void onTapToShowDialog(ctx, {darkModeModel}) async {
    String? userId = await SharedPreferencesServices.getData("userId");
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
        return UserScreen(userId: userId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Consumer2<DarkModeModel, ActiveNavModel>(
        builder: (context, darkModeModel, activeNavModel, child) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: darkModeModel.isDarkMode
            ? socialBrightnessLight
            : socialBrightnessDark,
      ));
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
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
                      iconSize: 24,
                      buttonIcon: Icons.info,
                      buttonColor: socialPrimaryColor,
                      iconColor: Colors.white,
                      onPressed: () {
                        onTapToShowDialog(
                          context,
                          darkModeModel: darkModeModel,
                        );
                      },
                    ),
                  ),
                  Text(
                    _textTitle(activeNavModel.activeNav),
                    style: TextStyle(
                      fontSize: textSizeMedium,
                      color: darkModeModel.isDarkMode
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
                      buttonIcon: Icons.settings,
                      buttonColor: Colors.grey[300],
                      iconColor: Colors.black,
                      onPressed: () {
                        Navigator.pushNamed(context, "/settings");
                      },
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: darkModeModel.isDarkMode
                ? darkModeAppbarBackground
                : socialScaffoldBackgroundColor,
            elevation: 0.0,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChoosenBar(
                activeNavModel: activeNavModel,
                darkModeModel: darkModeModel,
              ),
              _getCurrentScreen(
                activeNavModel.activeNav,
                darkModeModel,
                activeNavModel,
              ),
            ],
          ),
          floatingActionButton: FloatingActionBubble(
            items: <Bubble>[
              Bubble(
                title: "Post status",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.add,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  _animationController!.reverse();
                  showGeneralDialog(
                    context: context,
                    transitionBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                    pageBuilder: (BuildContext buildContext,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return CreateStatusDialog();
                    },
                  );
                },
              ),
              Bubble(
                title: "Friends",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.people,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              FriendsScreen(darkModeModel: darkModeModel)));
                  _animationController!.reverse();
                },
              ),
            ],
            animation: _animation!,
            onPress: () => _animationController!.isCompleted
                ? _animationController!.reverse()
                : _animationController!.forward(),
            backGroundColor: Colors.blue,
            iconColor: Colors.white,
            iconData: Icons.menu,
          ));
    });
  }
}
