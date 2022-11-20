import 'dart:io';

import '../data/tree_parser.dart';
import 'entities/tree_node.dart';

/// Store that creates (examplary) decision trees.
class TreeDataStore {
  static TreeNode createExemplaryTree() {
    String jsonExamplesDir = "../data/json_examples";
    if (!Directory.current.path.endsWith("/domain")) {
      throw Exception(
          "Either change the above path or current working directoy.");
    }
    return getRootTreeNode("$jsonExamplesDir/nodes.json",
        "$jsonExamplesDir/decision_options.json");
  }
}
