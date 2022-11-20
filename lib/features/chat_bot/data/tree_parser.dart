import 'dart:convert';
import 'dart:io';

import '../domain/entities/decision_option.dart';
import '../domain/entities/decision_option_description.dart';
import '../domain/entities/finite_decision_outcome.dart';
import '../domain/entities/tree_node.dart';
import 'dtos/decision_option_description_dto.dart';
import 'dtos/decision_option_dto.dart';
import 'dtos/decision_outcome_dto.dart';
import 'dtos/tree_node_dto.dart';

// TODO: replace with package method if not used in CLI
T? firstWhereOrNull<T>(Iterable<T> iterable, bool Function(T element) test) {
  for (var element in iterable) {
    if (test(element)) return element;
  }
  return null;
}

/// Constructs a tree and returns the root node for given path for nodes and options.
TreeNode getRootTreeNode(String nodesPath, String optionsPath) {
  List<TreeNodeDTO> nodesDTO =
      parseElementsFromFilePath<TreeNodeDTO>(nodesPath);
  List<TreeNode> nodesWithoutOptions = List<TreeNode>.from(nodesDTO.map((e) =>
      TreeNode(
          id: e.id,
          isRoot: e.isRoot,
          decisionOutcome: e.outcome == null ? null : outcomeByDTO(e.outcome!),
          description: e.description,
          question: e.question)));
  List<DecisionOptionDTO> decisionOptionsDTO =
      parseElementsFromFilePath<DecisionOptionDTO>(optionsPath);

  // if there is no root node, we cannot construct a tree
  TreeNode? rootNode =
      firstWhereOrNull(nodesWithoutOptions, (element) => element.isRoot);
  if (rootNode == null) {
    throw Exception("No node is defined with {'isRoot': true}.");
  }

  // resolves reference for both startNode and endNode in DecisionOption
  List<DecisionOption> resolvedOptions = [];
  for (DecisionOptionDTO decisionOptionDTO in decisionOptionsDTO) {
    // resolve start node
    TreeNode? startNode = firstWhereOrNull(nodesWithoutOptions,
        (node) => node.id == decisionOptionDTO.startNodeId);
    if (startNode == null) {
      throw Exception(
          "Could not find matching start node for option: ${decisionOptionDTO.toJson()}");
    }

    // resolve end node
    TreeNode? endNode = firstWhereOrNull(
        nodesWithoutOptions, (node) => node.id == decisionOptionDTO.endNodeId);
    if (endNode == null) {
      throw Exception(
          "Could not find matching end node for option: ${decisionOptionDTO.toJson()}");
    }

    DecisionOption option = DecisionOption(
        id: decisionOptionDTO.id,
        startNode: startNode,
        endNode: endNode,
        description: decisionOptionDTO.description == null
            ? null
            : descriptionByDTO(decisionOptionDTO.description!));
    resolvedOptions.add(option);
  }

  // resolve reference of DecisionOptions for every TreeNode
  for (TreeNode node in nodesWithoutOptions) {
    node.options = List<DecisionOption>.from(
        resolvedOptions.where((option) => option.startNode.id == node.id));
  }
  return rootNode;
}

FiniteDecisionOutcome outcomeByDTO(DecisionOutcomeDTO dto) {
  return FiniteDecisionOutcome(
      successful: dto.successful, outcomeResult: dto.outcomeResult);
}

DecisionOptionDescription descriptionByDTO(DecisionOptionDescriptionDTO dto) {
  return DecisionOptionDescription(text: dto.text);
}

List<T> parseElementsFromFilePath<T>(String filePath) {
  File file = File(filePath);
  if (!file.existsSync()) {
    throw Exception("Input file does not exist: $filePath");
  }

  String data = file.readAsStringSync();
  return parseElementsFromString<T>(data);
}

List<T> parseElementsFromString<T>(String jsonInput) {
  Function(Map<String, dynamic>) factoryMethod;
  switch (T) {
    case TreeNodeDTO:
      factoryMethod = TreeNodeDTO.fromMap;
      break;
    case DecisionOptionDTO:
      factoryMethod = DecisionOptionDTO.fromMap;
      break;
    case DecisionOutcomeDTO:
      factoryMethod = DecisionOutcomeDTO.fromMap;
      break;
    case DecisionOptionDescriptionDTO:
      factoryMethod = DecisionOptionDescriptionDTO.fromMap;
      break;
    default:
      throw Exception("Given type is not supported for JSON parsing.");
  }

  Iterable mapObjects = jsonDecode(jsonInput);
  try {
    return List<T>.from(mapObjects.map((e) => factoryMethod(e)));
  } catch (e) {
    throw Exception("Could not parse data: $e");
  }
}
