import 'package:tech_challenge_app/features/chat_bot/domain/entities/decision_option.dart';
import 'package:tech_challenge_app/features/chat_bot/domain/entities/decision_option_description.dart';
import 'package:tech_challenge_app/features/chat_bot/domain/entities/finite_decision_outcome.dart';
import 'package:tech_challenge_app/features/chat_bot/domain/entities/tree_node.dart';

class TreeBuilderHelper {
  late TreeNode rootNode;
  late List<TreeNode> nodesByNumber;
  late List<DecisionOption> edgesByName;

  TreeBuilderHelper() {
    buildTree();
  }

  TreeNode node(int number) {
    if (number < 0 || number > 7) {
      throw Exception("Node number out of range: $number.");
    }
    return nodesByNumber[number];
  }

  DecisionOption option(String numbers) {
    Iterable candidates =
        edgesByName.where((element) => element.id == "e$numbers");
    if (candidates.length != 1) {
      throw Exception("Edge does not exist: $numbers");
    }
    return candidates.first;
  }

  TreeNode buildTree() {
    TreeNode node0 = TreeNode(id: "0", isRoot: true, question: "A or B or C?");
    TreeNode node1 =
        TreeNode(id: "1", isRoot: false, question: "A1 or A2 or A3?");
    TreeNode node2 = TreeNode(id: "2", isRoot: false, question: "B1 or B2?");
    TreeNode node3 = TreeNode(
        id: "3",
        isRoot: false,
        decisionOutcome: const FiniteDecisionOutcome(
            successful: true, outcomeResult: "A(A2XY)*A1"));
    TreeNode node4 = TreeNode(id: "4", isRoot: false, question: "X?");
    TreeNode node5 = TreeNode(
        id: "5",
        isRoot: false,
        decisionOutcome: const FiniteDecisionOutcome(
            successful: true, outcomeResult: "A(A2XY)*A2"));
    TreeNode node6 = TreeNode(id: "6", isRoot: false, question: "Y?");
    TreeNode node7 = TreeNode(
        id: "7",
        isRoot: false,
        decisionOutcome: const FiniteDecisionOutcome(
            successful: false, outcomeResult: "(BB1)*(BB2|C)"));

    rootNode = node0;
    nodesByNumber = [node0, node1, node2, node3, node4, node5, node6, node7];

    DecisionOption e01 = DecisionOption(
        id: "e01",
        startNode: node0,
        endNode: node1,
        description: const DecisionOptionDescription(text: "A"));
    DecisionOption e02 = DecisionOption(
        id: "e02",
        startNode: node0,
        endNode: node2,
        description: const DecisionOptionDescription(text: "B"));
    DecisionOption e07 = DecisionOption(
        id: "e07",
        startNode: node0,
        endNode: node7,
        description: const DecisionOptionDescription(text: "C"));
    node0.options = [e01, e02, e07];

    DecisionOption e13 = DecisionOption(
        id: "e13",
        startNode: node1,
        endNode: node3,
        description: const DecisionOptionDescription(text: "A1"));
    DecisionOption e14 = DecisionOption(
        id: "e14",
        startNode: node1,
        endNode: node4,
        description: const DecisionOptionDescription(text: "A2"));
    DecisionOption e15 = DecisionOption(
        id: "e15",
        startNode: node1,
        endNode: node5,
        description: const DecisionOptionDescription(text: "A3"));
    node1.options = [e13, e14, e15];

    DecisionOption e20 = DecisionOption(
        id: "e20",
        startNode: node2,
        endNode: node0,
        description: const DecisionOptionDescription(text: "B1"));
    DecisionOption e27 = DecisionOption(
        id: "e27",
        startNode: node2,
        endNode: node7,
        description: const DecisionOptionDescription(text: "B2"));
    node2.options = [e20, e27];

    DecisionOption e46 = DecisionOption(
        id: "e46",
        startNode: node4,
        endNode: node6,
        description: const DecisionOptionDescription(text: "X"));
    node4.options = [e46];

    DecisionOption e61 = DecisionOption(
        id: "e61",
        startNode: node6,
        endNode: node1,
        description: const DecisionOptionDescription(text: "Y"));
    node6.options = [e61];

    edgesByName = [e01, e02, e07, e13, e14, e15, e20, e27, e46, e61];

    return node0;
  }
}
