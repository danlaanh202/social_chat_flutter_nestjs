import 'package:flutter/material.dart';
import 'package:social_chat/constants/social_colors.dart';

// ignore: must_be_immutable
class MySquareButton extends StatelessWidget {
  final Function onPressed;
  double? width;
  double? height;
  double? iconSize;
  IconData? buttonIcon;
  Color? buttonColor;
  Color? iconColor;
  MySquareButton({
    Key? key,
    required this.onPressed,
    this.width = 36,
    this.height = 36,
    this.buttonIcon = Icons.arrow_back_ios_outlined,
    this.iconSize = 18,
    this.iconColor,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
            elevation: 4,
            padding: EdgeInsets.zero,
            backgroundColor: buttonColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: Icon(
          buttonIcon,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
