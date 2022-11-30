import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_challenge_app/features/chat_bot/domain/entities/tree_node.dart';
import 'package:tech_challenge_app/features/chat_bot/presentation/bloc/chat_bot_bloc.dart';
import 'package:tech_challenge_app/features/chat_bot/presentation/widgets/chat_bot_nav_bar.dart';
import 'package:tech_challenge_app/features/chat_bot/presentation/widgets/chat_widget.dart';
import 'package:tech_challenge_app/features/chat_bot/presentation/widgets/option_grid.dart';

import '../../../../injection_container.dart';

class ChatBot extends StatelessWidget {
  final TreeNode treeNode;
  const ChatBot({Key? key, required this.treeNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBotBloc>(
      lazy: false,
      create: (context) =>
          sl<ChatBotBloc>()..add(ChatBotStartEvent(treeNode: treeNode)),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
            child: Column(
          children: const [
            ChatBotNavBar(),
            Expanded(child: ChatWidget()),
            OptionGrid(),
          ],
        )),
      ),
    );
  }
}
