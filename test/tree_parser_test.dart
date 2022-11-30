import 'package:flutter_test/flutter_test.dart';
import 'package:tech_challenge_app/features/chat_bot/data/tree_parser.dart';
import 'package:tech_challenge_app/features/chat_bot/domain/entities/tree_node.dart';

import 'tree_builder_helper.dart';

void main() {
  const String testDataDirPath = "test/tree_data";

  const String nodesFilePath = "$testDataDirPath/nodes.json";

  const String edgesFilePath = "$testDataDirPath/edges.json";

  late TreeNode actualRootNode;
  late TreeBuilderHelper helper = TreeBuilderHelper();

  n(int number) => helper.node(number);

  setUp(() async {
    actualRootNode = await getRootTreeNode(nodesFilePath, edgesFilePath);
    helper = TreeBuilderHelper();
  });

  test('should load model correctly', () {
    // hacky way to prevent circular dependencies causing an Stack Overflow when
    // using '=='. Comparing the nodes is enough as they already contain the edges.
    TreeNode currentNode = actualRootNode;
    expect(currentNode.toString(), equals(n(0).toString()));

    // from 0 -> {1, 2, 7}
    currentNode = actualRootNode.options[0].endNode;
    expect(currentNode.toString(), equals(n(1).toString()));
    currentNode = actualRootNode.options[1].endNode;
    expect(currentNode.toString(), equals(n(2).toString()));
    currentNode = actualRootNode.options[2].endNode;
    expect(currentNode.toString(), equals(n(7).toString()));

    // from 1 -> {3, 4, 5}
    currentNode = actualRootNode.options[0].endNode.options[0].endNode;
    expect(currentNode.toString(), equals(n(3).toString()));
    currentNode = actualRootNode.options[0].endNode.options[1].endNode;
    expect(currentNode.toString(), equals(n(4).toString()));
    currentNode = actualRootNode.options[0].endNode.options[2].endNode;
    expect(currentNode.toString(), equals(n(5).toString()));

    // from 2 -> {0, 7}
    currentNode = actualRootNode.options[1].endNode.options[0].endNode;
    expect(currentNode.toString(), equals(n(0).toString()));
    currentNode = actualRootNode.options[1].endNode.options[1].endNode;
    expect(currentNode.toString(), equals(n(7).toString()));

    // from 4 -> {6}
    currentNode =
        actualRootNode.options[0].endNode.options[1].endNode.options[0].endNode;
    expect(currentNode.toString(), equals(n(6).toString()));

    // from 6 -> {1}
    currentNode = actualRootNode.options[0].endNode.options[1].endNode
        .options[0].endNode.options[0].endNode;
    expect(currentNode.toString(), equals(n(1).toString()));
  });
}
