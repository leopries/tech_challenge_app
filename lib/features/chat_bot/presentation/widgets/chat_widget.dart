import 'package:flutter/material.dart';
import 'package:tech_challenge_app/features/chat_bot/presentation/widgets/messsage_widget.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return MessageWidget(
            isBot: index % 2 == 0,
            showLoadingAnimation: index % 2 == 0,
            child: Text(
              index % 2 == 0
                  ? "What kind of assult?"
                  : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr",
              style: TextStyle(
                color: index % 2 == 0
                    ? Theme.of(context).colorScheme.tertiary
                    : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          );
        },
      ),
    );
  }
}
