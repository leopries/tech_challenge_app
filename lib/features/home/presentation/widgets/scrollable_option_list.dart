import 'package:flutter/material.dart';
import 'package:tech_challenge_app/features/chat_bot/presentation/pages/chat_bot.dart';

import '../../../../core/widgets/option_item.dart';
import '../../../chat_bot/domain/entities/tree_node.dart';
import '../../../chat_bot/domain/tree_data_store.dart';

class ScrollableOptionList extends StatelessWidget {
  const ScrollableOptionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: CustomScrollView(scrollDirection: Axis.horizontal, slivers: [
        FutureBuilder<TreeNode>(
            future: TreeDataStore.createExemplaryTree(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      List<Widget> list = [];
                      const spacer = SizedBox(width: 20);
                      if (index == 0) {
                        list.add(spacer);
                      }
                      list.add(OptionItem(
                        imgPath: '',
                        text: 'I experienced a violent assault',
                        onTap: (context) =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatBot(
                            treeNode: snapshot.data!,
                          ),
                        )),
                      ));
                      list.add(spacer);
                      return Row(children: list);
                    },
                    childCount: 10,
                  ),
                );
              }
              return const SliverToBoxAdapter(
                child: SizedBox(),
              );
            })
      ]),
    );
  }
}
