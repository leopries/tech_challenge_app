import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

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
              list.add(const OptionListItem(
                imgPath: '',
                text: 'I experienced a violent assault',
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

class OptionListItem extends StatelessWidget {
  final String text;
  final String imgPath;

  const OptionListItem({Key? key, required this.text, required this.imgPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 140,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Icon(
              Icons.arrow_forward,
              color: Theme.of(context).colorScheme.secondary,
              size: 20,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
                height: 40,
                child: Opacity(
                  opacity: 0.33,
                  child: SimpleShadow(
                    opacity: 0.7,
                    sigma: 3,
                    child: Image.asset('assets/images/fist.png'),
                  ),
                )),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
