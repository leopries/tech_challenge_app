import 'package:flutter/material.dart';
import 'package:tech_challenge_app/features/home/presentation/widgets/home_nav_bar.dart';
import 'package:tech_challenge_app/features/home/presentation/widgets/robo_image.dart';
import 'package:tech_challenge_app/features/home/presentation/widgets/start_option_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: const [
            HomeNavBar(),
            Expanded(child: RoboImage()),
            StartOptionList(),
            SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
