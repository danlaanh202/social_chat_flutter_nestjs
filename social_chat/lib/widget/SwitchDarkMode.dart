import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/DarkModeModel.dart';

class SwitchDarkMode extends StatelessWidget {
  const SwitchDarkMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeModel>(
        builder: (context, model, child) => Row(
              children: [
                model.isDarkMode
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode),
                const Padding(padding: EdgeInsets.only(right: 8)),
                SizedBox(
                  width: 48,
                  height: 20,
                  child: Switch(
                    // This bool value toggles the switch.
                    value: model.isDarkMode,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      model.toggleTheme();
                    },
                  ),
                )
              ],
            ));
  }
}
