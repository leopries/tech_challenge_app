import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/tree_node.dart';
import '../bloc/chat_bot_bloc.dart';
import '../widgets/chat_bot_nav_bar.dart';
import '../widgets/chat_widget.dart';
import '../widgets/final_answer_sheet.dart';
import '../widgets/option_grid.dart';

class ChatBot extends StatelessWidget {
  final TreeNode treeNode;
  const ChatBot({Key? key, required this.treeNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBotBloc>(
      lazy: false,
      create: (context) =>
          sl<ChatBotBloc>()..add(ChatBotStartEvent(treeNode: treeNode)),
      child: Builder(builder: (context) {
        return BlocListener<ChatBotBloc, ChatBotState>(
          listener: (context, state) {
            if (state is ChatBotFinal) {
              _showModalBottomSheet(context, state.message);
            }
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SafeArea(
                child: Column(
              children: [
                const ChatBotNavBar(),
                Expanded(child: ChatWidget()),
                const OptionGrid(),
              ],
            )),
          ),
        );
      }),
    );
  }

  _showModalBottomSheet(BuildContext context, String message) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return FinalAnswerSheet(message: message);
        });
  }
}
