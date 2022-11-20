import 'decision_option.dart';
import 'finite_decision_outcome.dart';

/// Single node in the decision tree
class TreeNode {
  // unique id of the node
  final String id;

  /// optional description
  final String? description;

  /// question the chatbot asks. Null if no options exist
  final String? question;

  // Possible options to be taken. Null/Empty if no options exist
  List<DecisionOption>? options;

  /// An (optional) finite outcome.
  final FiniteDecisionOutcome? decisionOutcome;

  final bool isRoot;

  TreeNode(
      {required this.id,
      required this.isRoot,
      this.question,
      this.options,
      this.description,
      this.decisionOutcome});

  @override
  String toString() {
    return 'TreeNode(id: $id, description: $description, question: $question, options: $options, decisionOutcome: $decisionOutcome)';
  }
}
