import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/chat_message.dart';
import '../bloc/chat/chat_bloc.dart';
import '../bloc/chat_bot_bloc.dart';
import 'messsage_widget.dart';

class ChatWidget extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  ChatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<ChatBloc, ChatState>(
        bloc: BlocProvider.of<ChatBotBloc>(context).chatBloc,
        listener: (context, state) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
        builder: (context, state) {
          return ListView.builder(
            controller: _scrollController,
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
