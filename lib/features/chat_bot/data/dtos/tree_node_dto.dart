import 'dart:convert';

import 'decision_outcome_dto.dart';

class TreeNodeDTO {
  final String id;

  final String? description;

  final String? question;

  final bool isRoot;

  final DecisionOutcomeDTO? outcome;
  TreeNodeDTO({
    required this.id,
    this.isRoot = false,
    this.description,
    this.question,
    this.outcome,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'isRoot': isRoot});
    if (description != null) {
      result.addAll({'description': description});
    }
    if (question != null) {
      result.addAll({'question': question});
    }
    if (outcome != null) {
      result.addAll({'outcome': outcome!.toJson()});
    }

    return result;
  }

  factory TreeNodeDTO.fromMap(Map<String, dynamic> map) {
    return TreeNodeDTO(
      id: map['id'],
      description: map['description'],
      question: map['question'],
      isRoot: map['isRoot'] == true,
      outcome: map['outcome'] == null
          ? null
          : DecisionOutcomeDTO.fromMap(map['outcome']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TreeNodeDTO.fromJson(String source) =>
      TreeNodeDTO.fromMap(json.decode(source));
}
