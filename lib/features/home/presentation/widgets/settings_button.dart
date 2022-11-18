import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => debugPrint("open settings"),
      child: Icon(
        Icons.settings_outlined,
        color: Theme.of(context).colorScheme.tertiary,
        size: 30,
      ),
    );
  }
}
