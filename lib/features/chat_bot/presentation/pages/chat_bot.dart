import 'package:flutter/material.dart';
import 'package:tech_challenge_app/features/chat_bot/presentation/widgets/chat_bot_nav_bar.dart';
import 'package:tech_challenge_app/features/chat_bot/presentation/widgets/chat_widget.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Column(
        children: const [
          ChatBotNavBar(),
          Expanded(child: ChatWidget())
          // Options
        ],
      )),
    );
  }
}
