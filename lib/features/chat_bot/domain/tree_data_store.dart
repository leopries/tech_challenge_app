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

  static Future<List<TreeNode>> createTreeList() async {
    String jsonExamplesDir = "../data/tree_data";
    if (!Directory.current.path.endsWith("/domain")) {
      jsonExamplesDir = "assets/tree_data";
    }
    List<TreeNode> list = await Future.wait([
      getRootTreeNode("$jsonExamplesDir/sexual_assault/nodes.json",
          "$jsonExamplesDir/sexual_assault/edges.json"),
    ]);

    return list;
  }

  static Future<TreeNode> getSexualAssaultTreeNode() async {
    String jsonExamplesDir = "assets/tree_data";

    return await getRootTreeNode("$jsonExamplesDir/sexual_assault/nodes.json",
        "$jsonExamplesDir/sexual_assault/edges.json");
  }
}
