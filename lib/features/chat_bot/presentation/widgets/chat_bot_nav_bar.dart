import 'package:flutter/material.dart';
import 'package:tech_challenge_app/features/home/presentation/widgets/sos_button.dart';

class ChatBotNavBar extends StatelessWidget {
  const ChatBotNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.tertiary,
                size: 20,
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
    );
  }
}
