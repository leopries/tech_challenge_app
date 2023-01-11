import 'package:flutter/material.dart';

import '../../../home/presentation/widgets/sos_button.dart';

class ChatBotNavBar extends StatelessWidget {
  const ChatBotNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 16, bottom: 10, left: 20, right: 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 16, bottom: 8, top: 8),
                      child: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).colorScheme.tertiary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SOSButton()
                ],
              ),
              Text(
                "Chatbot",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          height: 1,
        ),
      ],
    );
  }
}
