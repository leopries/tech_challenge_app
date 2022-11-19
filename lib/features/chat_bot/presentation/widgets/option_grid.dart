import 'package:flutter/material.dart';
import 'package:tech_challenge_app/core/widgets/option_item.dart';

class OptionGrid extends StatelessWidget {
  const OptionGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'choose one option',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                OptionItem(
                  imgPath: '',
                  text: 'I experienced a violent assault',
                  onTap: () => debugPrint("Option Button pressed"),
                ),
                OptionItem(
                  imgPath: '',
                  text: 'I experienced a violent assault',
                  onTap: () => debugPrint("Option Button pressed"),
                ),
                OptionItem(
                  imgPath: '',
                  text: 'I experienced a violent assault',
                  onTap: () => debugPrint("Option Button pressed"),
                ),
                OverflowBox(
                  child: OptionItem(
                    imgPath: '',
                    text: 'Other',
                    onTap: () => debugPrint("Option Button pressed"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
