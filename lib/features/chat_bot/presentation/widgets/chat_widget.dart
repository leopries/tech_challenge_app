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
            cacheExtent: 1000,
            itemCount: state.chatMessages.length,
            itemBuilder: (context, index) {
              final message = state.chatMessages[index];
              return MessageWidget(
                key: ValueKey(message.id),
                scrollController: _scrollController,
                isBot: message.owner == MessageOwner.robot,
                showLoadingAnimation: message.owner == MessageOwner.robot,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: index % 2 == 0
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    children: _buildTextSpans(message.text),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<TextSpan> _buildTextSpans(String text) {
    final pattern = RegExp(r'\*(.+?)\*');
    final matches = pattern.allMatches(text);
    int currentPosition = 0;
    final spans = <TextSpan>[];
    for (Match match in matches) {
      if (match.start > currentPosition) {
        spans.add(TextSpan(
          text: text.substring(currentPosition, match.start),
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ));
      currentPosition = match.end;
    }
    if (currentPosition < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentPosition),
      ));
    }
    return spans;
  }
}
