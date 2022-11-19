import 'package:flutter/material.dart';

class SOSButton extends StatelessWidget {
  const SOSButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 39,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Center(
          child: Text(
        "SOS",
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}
