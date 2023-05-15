import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/models/DarkModeModel.dart';
import 'package:social_chat/models/status.model.dart';
import 'package:social_chat/services/post_services.dart';
import 'package:social_chat/widget/MyCard.dart';
import 'package:social_chat/widget/StatusCard.dart';
import 'package:social_chat/widget/status/CreateStatusDialog.dart';

import '../widget/status/StatusItem.dart';

class HomeStatusScreen extends StatefulWidget {
  final DarkModeModel darkModeModel;
  const HomeStatusScreen({Key? key, required this.darkModeModel})
      : super(key: key);

  @override
  _HomeStatusScreenState createState() => _HomeStatusScreenState();
}

class _HomeStatusScreenState extends State<HomeStatusScreen> {
  List<Status?> _statusList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PostServices.getStatus().then((data) {
      print("Author id: ${data[0]?.authorId}");
      setState(() {
        _statusList = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Expanded(
      child: ListView.builder(
        itemCount: _statusList.length,
        itemBuilder: (context, index) {
          return StatusItem(
            statusItem: _statusList[index],
          );
        },
      ),

      // SingleChildScrollView(
      //   child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      // Container(
      //   margin: const EdgeInsets.symmetric(horizontal: 24),
      //   child: const Text("My Status"),
      // ),
      // GestureDetector(
      //   onTap: () {
      //     showGeneralDialog(
      //       context: context,
      //       transitionBuilder:
      //           (context, animation, secondaryAnimation, child) {
      //         const begin = Offset(0.0, 1.0);
      //         const end = Offset.zero;
      //         const curve = Curves.ease;

      //         var tween = Tween(begin: begin, end: end)
      //             .chain(CurveTween(curve: curve));

      //         return SlideTransition(
      //           position: animation.drive(tween),
      //           child: child,
      //         );
      //       },
      //       pageBuilder: (BuildContext buildContext,
      //           Animation<double> animation,
      //           Animation<double> secondaryAnimation) {
      //         return CreateStatusDialog();
      //       },
      //     );
      //   },
      //   child: Container(
      //     margin: const EdgeInsets.symmetric(horizontal: 24),
      //     child: Padding(
      //       padding: const EdgeInsets.all(4),
      //       child: Container(
      //         clipBehavior: Clip.hardEdge,
      //         decoration: BoxDecoration(
      //           color: cardItemBackground,
      //           borderRadius: BorderRadius.circular(8),
      //         ),
      //         child: Column(
      //           children: [
      //             MyCard(
      //               darkModeModel: widget.darkModeModel,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      // Container(
      //   margin: const EdgeInsets.symmetric(horizontal: 24),
      //   child: const Text("Status"),
      // ),

      //       ]),
      // ),
    );
  }
}
