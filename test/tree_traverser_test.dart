import 'package:flutter_test/flutter_test.dart';
import 'package:tech_challenge_app/features/chat_bot/domain/entities/tree_node.dart';
import 'package:tech_challenge_app/features/chat_bot/domain/tree_traverser.dart';

import 'tree_builder_helper.dart';

void main() {
  late TreeTraverser traverser;
  late TreeBuilderHelper helper;
  late TreeNode rootNode;

  n(int number) => helper.node(number);
  e(String edgeName) => helper.option(edgeName);

  setUp(() {
    helper = TreeBuilderHelper();
    rootNode = helper.buildTree();
    traverser = TreeTraverser(rootNode);
  });

  test('should init as root', () {
    expect(traverser.currentNode, equals(n(0)));
    expect(traverser.availableOptions, equals([e("01"), e("02"), e("07")]));
  });

  test('follow simple line: 0-1-3', () {
    expect(traverser.chooseOption(e("01")), equals(n(1)));
    expect(traverser.currentNode, n(1));
    expect(traverser.availableOptions, equals([e("13"), e("14"), e("15")]));
    expect(traverser.chooseOption(e("13")), equals(n(3)));
    expect(traverser.currentNode, equals(n(3)));
    expect(traverser.availableOptions, isEmpty);
  });

  test('make a three node loop: 0-1-4-6-1-5', () {
    expect(traverser.chooseOption(e("01")), equals(n(1)));
    expect(traverser.chooseOption(e("14")), equals(n(4)));
    expect(traverser.currentNode, equals(n(4)));
    expect(traverser.availableOptions, equals([e("46")]));
    expect(traverser.chooseOption(e("46")), equals(n(6)));
    expect(traverser.currentNode, n(6));
    expect(traverser.availableOptions, equals([e("61")]));
    expect(traverser.chooseOption(e("61")), equals(n(1)));
    expect(traverser.currentNode, equals(n(1)));
    expect(traverser.availableOptions, equals([e("13"), e("14"), e("15")]));
    expect(traverser.chooseOption(e("15")), equals(n(5)));
    expect(traverser.currentNode, equals(n(5)));
    expect(traverser.availableOptions, isEmpty);
  });

  test('run some loops: ((02)^3)27', () {
    for (int i = 0; i < 3; i++) {
      expect(traverser.chooseOption(e("02")), equals(n(2)));
      expect(traverser.currentNode, equals(n(2)));
      expect(traverser.availableOptions, equals([e("20"), e("27")]));
      expect(traverser.chooseOption(e("20")), equals(n(0)));
      expect(traverser.currentNode, equals(n(0)));
      expect(traverser.availableOptions, equals([e("01"), e("02"), e("07")]));
    }

    expect(traverser.chooseOption(e("07")), equals(n(7)));
    expect(traverser.currentNode, equals(n(7)));
    expect(traverser.availableOptions, isEmpty);
  });
}
