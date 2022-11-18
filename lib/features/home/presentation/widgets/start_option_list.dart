import 'package:flutter/material.dart';
import 'package:tech_challenge_app/features/home/presentation/widgets/list_header.dart';
import 'package:tech_challenge_app/features/home/presentation/widgets/scrollable_option_list.dart';

class StartOptionList extends StatelessWidget {
  const StartOptionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListHeader(),
        ScrollableOptionList(),
      ],
    );
  }
}
