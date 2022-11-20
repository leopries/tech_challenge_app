import 'package:tech_challenge_app/features/chat_bot/domain/entities/tree_node.dart';

import 'decision_option_description.dart';

/// Decision option, selectable from a node.
class DecisionOption {
  /// unique id
  final String id;

  /// the node from which the option is selectable
  final TreeNode startNode;

  /// the node traversed to if decision is chosen
  final TreeNode endNode;

  /// description of the decision
  final DecisionOptionDescription? description;

  const DecisionOption(
      {required this.id,
      required this.startNode,
      required this.endNode,
      this.description});

  @override
  String toString() =>
      'DecisionOption(startNode: $startNode, endNode: $endNode, description: $description)';
}
