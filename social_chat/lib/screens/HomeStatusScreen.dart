import 'package:flutter/material.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/models/DarkModeModel.dart';

import 'package:social_chat/widget/MyCard.dart';
import 'package:social_chat/widget/StatusCard.dart';

class HomeStatusScreen extends StatefulWidget {
  final DarkModeModel darkModeModel;
  const HomeStatusScreen({Key? key, required this.darkModeModel})
      : super(key: key);

  @override
  _HomeStatusScreenState createState() => _HomeStatusScreenState();
}

class _HomeStatusScreenState extends State<HomeStatusScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: const Text("My Status"),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: cardItemBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      MyCard(
                        darkModeModel: widget.darkModeModel,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: const Text("Status"),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: cardItemBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      StatusCard(
                        darkModeModel: widget.darkModeModel,
                      ),
                      StatusCard(
                        darkModeModel: widget.darkModeModel,
                      ),
                      StatusCard(
                        darkModeModel: widget.darkModeModel,
                      ),
                      StatusCard(
                        darkModeModel: widget.darkModeModel,
                      ),
                      StatusCard(
                        darkModeModel: widget.darkModeModel,
                      ),
                      StatusCard(
                        darkModeModel: widget.darkModeModel,
                      ),
                      StatusCard(
                        darkModeModel: widget.darkModeModel,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
    ));
  }
}
