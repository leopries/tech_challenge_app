import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/option_item.dart';
import '../bloc/chat_bot_bloc.dart';

class OptionGrid extends StatelessWidget {
  const OptionGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'choose one option',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: BlocBuilder<ChatBotBloc, ChatBotState>(
              builder: (context, state) {
                return Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: buildChildrenFromState(state),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildChildrenFromState(ChatBotState state) {
    if (state is ChatBotLoading) {
      // TODO: implement Loading widget
      return [];
    }
    if (state is ChatBotLoaded) {
      return state.treeNode.options
          .map(
            (option) => OptionItem(
              text: option.description?.text ?? "",
              imgPath: "assets/images/fist.png",
              onTap: (context) => BlocProvider.of<ChatBotBloc>(context)
                  .add(ChatBotChooceOptionEvent(decisionOption: option)),
            ),
          )
          .toList();
    }
    return [];
  }
}
