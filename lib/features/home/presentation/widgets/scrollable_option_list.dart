import 'package:flutter/material.dart';

import '../../../../core/widgets/option_item.dart';
import '../../../chat_bot/domain/entities/tree_node.dart';
import '../../../chat_bot/domain/tree_data_store.dart';
import '../../../chat_bot/presentation/pages/chat_bot.dart';

class ScrollableOptionList extends StatelessWidget {
  const ScrollableOptionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: CustomScrollView(scrollDirection: Axis.horizontal, slivers: [
        FutureBuilder<List<TreeNode>>(
            future: TreeDataStore.createTreeList(),
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
                        imgPath: 'assets/images/fist.png',
                        text: 'Sexual Assault',
                        onTap: (context) =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatBot(
                            treeNode: snapshot.data![0],
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
