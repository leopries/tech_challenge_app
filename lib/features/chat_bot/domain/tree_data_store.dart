import 'dart:io';

import '../data/tree_parser.dart';
import 'entities/tree_node.dart';

/// Store that creates (examplary) decision trees.
class TreeDataStore {
  static Future<TreeNode> createExemplaryTree() async {
    String jsonExamplesDir = "../data/json_examples";
    if (!Directory.current.path.endsWith("/domain")) {
      jsonExamplesDir = "assets/json_examples";
    }
    return await getRootTreeNode("$jsonExamplesDir/nodes.json",
        "$jsonExamplesDir/decision_options.json");
  }
}
