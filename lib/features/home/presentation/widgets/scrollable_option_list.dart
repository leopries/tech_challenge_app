import 'package:flutter/material.dart';

import '../../../../core/widgets/option_item.dart';

class ScrollableOptionList extends StatelessWidget {
  const ScrollableOptionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: CustomScrollView(scrollDirection: Axis.horizontal, slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              List<Widget> list = [];
              const spacer = SizedBox(width: 20);
              if (index == 0) {
                list.add(spacer);
              }
              list.add(OptionItem(
                imgPath: '',
                text: 'I experienced a violent assault',
                onTap: () => debugPrint("Option Button pressed"),
              ));
              list.add(spacer);
              return Row(children: list);
            },
            childCount: 10,
          ),
        )
      ]),
    );
  }
}
