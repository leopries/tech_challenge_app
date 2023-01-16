import 'package:flutter/material.dart';

import '../widgets/home_nav_bar.dart';
import '../widgets/robo_image.dart';
import '../widgets/start_option_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: InkWell(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: const [
              HomeNavBar(),
              Expanded(child: RoboImage()),
              StartOptionList(),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
