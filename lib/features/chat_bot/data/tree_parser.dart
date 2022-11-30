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

import 'package:flutter/services.dart' show rootBundle;

// TODO: replace with package method if not used in CLI
T? firstWhereOrNull<T>(Iterable<T> iterable, bool Function(T element) test) {
  for (var element in iterable) {
    if (test(element)) return element;
  }
  return null;
}

/// Constructs a tree and returns the root node for given path for nodes and options.
Future<TreeNode> getRootTreeNode(String nodesPath, String optionsPath) async {
  List<TreeNodeDTO> nodesDTO =
      await parseElementsFromFilePath<TreeNodeDTO>(nodesPath);
  List<TreeNode> nodesWithoutOptions = List<TreeNode>.from(nodesDTO.map((e) =>
      TreeNode(
          id: e.id,
          isRoot: e.isRoot,
          decisionOutcome: e.outcome == null ? null : outcomeByDTO(e.outcome!),
          description: e.description,
          question: e.question)));
  List<DecisionOptionDTO> decisionOptionsDTO =
      await parseElementsFromFilePath<DecisionOptionDTO>(optionsPath);

  // if there is not exactly one root node, we cannot construct a tree
  Iterable treeNodeCandidates =
      nodesWithoutOptions.where((element) => element.isRoot);
  if (treeNodeCandidates.length != 1) {
    throw Exception(
        "Not exactly one node contains {'isRoot': true}, but ${treeNodeCandidates.length}");
  }
  TreeNode rootNode = treeNodeCandidates.first;

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

Future<List<T>> parseElementsFromFilePath<T>(String filePath) async {
  String data;
  if (Platform.isIOS || Platform.isAndroid) {
    data = await rootBundle.loadString(filePath);
  } else {
    File file = File(filePath);
    if (!file.existsSync()) {
      throw Exception("Input file does not exist: $filePath");
    }

    data = file.readAsStringSync();
  }

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

  List mapObjects = jsonDecode(jsonInput);
  try {
    return List<T>.from(mapObjects.map((e) => factoryMethod(e)));
  } catch (e) {
    throw Exception("Could not parse data: $e");
  }
}
