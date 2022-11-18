import 'package:flutter/material.dart';
import 'package:tech_challenge_app/features/home/presentation/widgets/settings_button.dart';
import 'package:tech_challenge_app/features/home/presentation/widgets/sos_button.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SOSButton(),
          SettingsButton(),
        ],
      ),
    );
  }
}
