import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class OptionItem extends StatefulWidget {
  final String text;
  final String imgPath;
  final Function() onTap;

  const OptionItem({
    Key? key,
    required this.text,
    required this.imgPath,
    required this.onTap,
  }) : super(key: key);

  @override
  State<OptionItem> createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  late Color primary = Theme.of(context).colorScheme.primary;
  late Color tertiary = Theme.of(context).colorScheme.tertiary;

  late Color background = primary;
  late Color fontColor = tertiary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onTapDown: (_) => press(up: false),
      onTapUp: (_) => press(up: true),
      onTapCancel: () => press(up: true),
      child: Container(
        height: 140,
        width: 140,
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: background,
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
                      color: fontColor,
                      sigma: 3,
                      child: Image.asset(
                        'assets/images/fist.png',
                        color: fontColor,
                      ),
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: fontColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void press({required bool up}) {
    if (up) {
      setState(() {
        fontColor = tertiary;
        background = primary;
      });
    } else {
      setState(() {
        fontColor = primary;
        background = tertiary;
      });
    }
  }
}
