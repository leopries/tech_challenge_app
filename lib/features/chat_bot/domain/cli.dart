import 'dart:io';

import 'package:tech_challenge_app/features/chat_bot/domain/tree_data_store.dart';
import 'package:tech_challenge_app/features/chat_bot/domain/tree_traverser.dart';

import 'entities/tree_node.dart';

/// Run via 'dart cli.dart'
void main() {
  TreeNode exampleRootNode = TreeDataStore.createExemplaryTree();
  TreeTraverser traverser = TreeTraverser(exampleRootNode);

  // traverserCLI(traverser);
  numberCLI(traverser);
}

void numberCLI(TreeTraverser traverser) {
  while (traverser.areOptionsAvailableFromCurrentNode()) {
    stdout.write(traverser.currentNode.question);
    var options = traverser.availableOptions;
    for (int i = 1; i <= options.length; i++) {
      stdout.write("($i): ${options.elementAt(i - 1).description!.text}");
    }
    String? chosenOptionStr = stdin.readLineSync();
    int chosenOptionNumber = int.parse(chosenOptionStr!);
    if (chosenOptionNumber > options.length) {
      stdout.write("Failure, wrong number");
      continue;
    }

    traverser.chooseOption(options.elementAt(chosenOptionNumber - 1));
  }

  stdout.write(traverser.getDecisionOutcome());
}

void traverserCLI(TreeTraverser traverser) {
  while (true) {
    String? chosenOption = stdin.readLineSync();
    if (chosenOption == null) {
      continue;
    }

    String? result;
    switch (chosenOption) {
      case '1':
        result = traverser.currentNode.toString();
        break;
      case '2':
        result = traverser.lastSelectedOption?.toString();
        break;
      case '3':
        result = traverser.isStartNode.toString();
        break;
      case '4':
        result = traverser.hasLegalResult().toString();
        break;
      case '5':
        result = traverser.getDecisionOutcome()?.toString();
        break;
      case '6':
        result = traverser.areOptionsAvailableFromCurrentNode().toString();
        break;
      case '7':
        result = traverser.moveStepBack().toString();
        break;
      case '8':
        result = traverser
            .chooseOption(traverser.availableOptions.elementAt(0))
            .toString();
        break;
      case '9':
        result = traverser
            .chooseOption(traverser.availableOptions.elementAt(1))
            .toString();
        break;
      case '10':
        result = traverser.availableOptions.toString();
        break;
    }
    stdout.write(result);
  }
}
