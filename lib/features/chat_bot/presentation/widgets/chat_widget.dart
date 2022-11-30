import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_challenge_app/features/chat_bot/domain/entities/chat_message.dart';
import 'package:tech_challenge_app/features/chat_bot/presentation/bloc/chat_bot_bloc.dart';
import 'package:tech_challenge_app/features/chat_bot/presentation/widgets/messsage_widget.dart';

import '../bloc/chat/chat_bloc.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<ChatBloc, ChatState>(
        bloc: BlocProvider.of<ChatBotBloc>(context).chatBloc,
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.chatMessages.length,
            itemBuilder: (context, index) {
              final message = state.chatMessages[index];
              return MessageWidget(
                key: ValueKey(message.id),
                isBot: message.owner == MessageOwner.robot,
                showLoadingAnimation: message.owner == MessageOwner.robot,
                child: Text(
                  message.text,
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
          );
        },
      ),
    );
  }
}
