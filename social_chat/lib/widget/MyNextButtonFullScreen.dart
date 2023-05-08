import 'package:flutter/material.dart';

class MyNextButtonFullScreen extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  const MyNextButtonFullScreen(
      {Key? key, required this.onPressed, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            buttonText,
            style: const TextStyle(),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_right_alt_rounded)
        ],
      ),
    );
  }
}
