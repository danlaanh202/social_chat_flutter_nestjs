import 'package:flutter/material.dart';
import 'package:social_chat/constants/social_colors.dart';
import 'package:social_chat/widget/CallCard.dart';
import 'package:social_chat/widget/MyCard.dart';
import 'package:social_chat/widget/StatusCard.dart';

class HomeCallScreen extends StatelessWidget {
  final darkModeModel;
  const HomeCallScreen({Key? key, required this.darkModeModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: const Text("Cuộc gọi"),
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
                      CallCard(
                        darkModeModel: darkModeModel,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: const Text("Missing calls"),
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
                      CallCard(
                        darkModeModel: darkModeModel,
                      ),
                      CallCard(
                        darkModeModel: darkModeModel,
                      ),
                      CallCard(
                        darkModeModel: darkModeModel,
                      ),
                      CallCard(
                        darkModeModel: darkModeModel,
                      ),
                      CallCard(
                        darkModeModel: darkModeModel,
                      ),
                      CallCard(
                        darkModeModel: darkModeModel,
                      ),
                      CallCard(
                        darkModeModel: darkModeModel,
                      ),
                      CallCard(
                        darkModeModel: darkModeModel,
                      ),
                      CallCard(
                        darkModeModel: darkModeModel,
                      ),
                      CallCard(
                        darkModeModel: darkModeModel,
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
