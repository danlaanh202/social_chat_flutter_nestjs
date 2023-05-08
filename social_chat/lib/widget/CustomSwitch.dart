import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSwitch extends StatelessWidget {
  bool isOn;
  final void Function(bool)? toggleSwitch;
  CustomSwitch({Key? key, required this.isOn, required this.toggleSwitch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 48,
          height: 20,
          child: Switch(
            // This bool value toggles the switch.
            value: isOn,
            activeColor: Theme.of(context).primaryColor,
            onChanged: toggleSwitch,
          ),
        )
      ],
    );
  }
}
