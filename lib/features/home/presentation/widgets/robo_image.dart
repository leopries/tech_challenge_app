import 'package:flutter/material.dart';

class RoboImage extends StatelessWidget {
  const RoboImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
          padding: EdgeInsets.all(constraints.maxHeight / 10),
          child: FittedBox(
              child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 1, minHeight: 1),
            child: Transform.scale(
              scale: 1.2,
              child: Image.asset(
                'assets/images/robot.png',
                filterQuality: FilterQuality.high,
              ),
            ),
          )));
    });
  }
}
