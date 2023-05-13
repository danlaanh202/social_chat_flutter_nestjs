import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat/models/ActiveNavModel.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/providers/socket.provider.dart';
import 'package:social_chat/screens/LoginScreen.dart';
import 'package:social_chat/screens/RegisterScreen.dart';
import 'package:social_chat/screens/SettingsScreen.dart';
import 'package:social_chat/services/auth_services.dart';
import 'package:social_chat/services/shared_pref_service.dart';
import 'package:social_chat/widget/DismissKeyboard.dart';
import 'screens/SplashScreen.dart';
import 'package:flutter/services.dart';
import 'screens/HomeScreen.dart';
import 'constants/social_colors.dart';
import 'constants/theme_data.dart';
import "package:socket_io_client/socket_io_client.dart" as IO;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // HttpOverrides.global = MyHttpOverrides();
  bool isLoggedIn = await AuthServices.isLoggedIn();
  final socketProvider = SocketProvider();
  socketProvider.connect();

  // Kiểm tra xem người dùng đã đăng nhập hay chưa
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DarkModeModel()),
        ChangeNotifierProvider(create: (_) => ActiveNavModel()),
        ChangeNotifierProvider.value(value: socketProvider),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool? isLoggedIn;
  const MyApp({Key? key, this.isLoggedIn}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AuthServices.getCurrentAccessToken().then((token) {
      // print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<DarkModeModel, ActiveNavModel>(
        builder: (context, darkModel, activeNavModel, child) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            darkModel.isDarkMode ? socialBrightnessLight : socialBrightnessDark,
      ));
      return DismissKeyboard(
          child: MaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              themeMode:
                  darkModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              theme: lightTheme,
              darkTheme: darkTheme,
              home: widget.isLoggedIn!
                  ? const HomeScreen()
                  : const SplashScreen(),
              routes: <String, WidgetBuilder>{
            "/splash": (BuildContext context) => const SplashScreen(),
            "/home": (BuildContext context) => const HomeScreen(),
            "/login": (BuildContext context) => const LoginScreen(),
            "/register": (BuildContext context) => const RegisterScreen(),
            "/settings": (BuildContext context) => SettingsScreen(
                  darkModeModel: darkModel,
                  activeNavModel: activeNavModel,
                ),
          }));
    });
  }
}
