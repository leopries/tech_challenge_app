import 'dart:convert';

import 'decision_option_description_dto.dart';

class DecisionOptionDTO {
  final String id;

  final String startNodeId;

  final String endNodeId;

  // null for root node
  final DecisionOptionDescriptionDTO? description;

  const DecisionOptionDTO(
      {required this.id,
      required this.startNodeId,
      required this.endNodeId,
      this.description});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'startNodeId': startNodeId});
    result.addAll({'endNodeId': endNodeId});
    if (description != null) {
      result.addAll({'description': description!.toMap()});
    }

    return result;
  }

  factory DecisionOptionDTO.fromMap(Map<String, dynamic> map) {
    return DecisionOptionDTO(
      id: map['id'],
      startNodeId: map['startNodeId'],
      endNodeId: map['endNodeId'],
      description: map['description'] == null
          ? null
          : DecisionOptionDescriptionDTO.fromMap(map['description']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DecisionOptionDTO.fromJson(String source) =>
      DecisionOptionDTO.fromMap(json.decode(source));
}
