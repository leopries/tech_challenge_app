import 'entities/decision_option.dart';
import 'entities/finite_decision_outcome.dart';
import 'entities/tree_node.dart';

/// Provides functionality to traverse the tree and provide a comfortable
/// interface to access various functionality that might be useful.
class TreeTraverser {
  /// The user-chosen options. Moving back in the tree removes options from the list.
  List<DecisionOption> chosenOptions = [];

  /// The traversed nodes. Moving back in the tree removes nodes from the list.
  /// Always contains the root node as the first element.
  List<TreeNode> traversedNodes = [];

  /// The initial root node.
  final TreeNode _rootNode;

  /// The current node.
  TreeNode _currentNode;

  /// The last chosen option. Is null when current node is the root node.
  DecisionOption? _lastSelectedOption;

  TreeTraverser(this._rootNode) : _currentNode = _rootNode {
    traversedNodes.add(_rootNode);
  }

  TreeNode get currentNode => _rootNode;

  DecisionOption? get lastSelectedOption => _lastSelectedOption;

  /// The selectable options from the current node.
  List<DecisionOption> get currentOptions => _rootNode.options ?? [];

  /// Reverts the last step and returns the current node after removal.
  TreeNode moveStepBack() {
    if (_rootNode == _currentNode || traversedNodes.length <= 1) {
      throw Exception("Cannot move back from root node.");
    }

    chosenOptions.removeLast();
    if (chosenOptions.isEmpty) {
      _lastSelectedOption = null;
    } else {
      _lastSelectedOption = chosenOptions.last;
    }
    traversedNodes.removeLast();
    // minimal length of 1
    _currentNode = traversedNodes.last;
    return _currentNode;
  }

  /// Returns the avaialble options from the current node.
  List<DecisionOption> get availableOptions => _currentNode.options ?? [];

  /// Choose an option from the current node and returns the node that is
  /// reached by chosing the option.
  TreeNode chooseOption(DecisionOption option) {
    if (_currentNode.options == null ||
        !_currentNode.options!.contains(option)) {
      throw Exception(
          "The passed option is not an option for the current node.");
    }

    _lastSelectedOption = option;
    chosenOptions.add(option);
    _currentNode = option.endNode;
    traversedNodes.add(_currentNode);
    return _currentNode;
  }

  /// Returns if the current node is the start node.
  bool get isStartNode => _currentNode == _rootNode;

  /// Returns if no option available from the current node anymore.
  bool areOptionsAvailableFromCurrentNode() {
    return availableOptions.isNotEmpty;
  }

  /// Returns if the current node holds a legal result.
  bool hasLegalResult() {
    return _currentNode.decisionOutcome != null;
  }

  /// Returns the legal result of the current node, or null if not existing.
  FiniteDecisionOutcome? getDecisionOutcome() {
    return _currentNode.decisionOutcome;
  }
}
