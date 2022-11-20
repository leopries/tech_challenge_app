import 'dart:convert';

class DecisionOutcomeDTO {
  final bool successful;

  final String? outcomeResult;

  const DecisionOutcomeDTO({required this.successful, this.outcomeResult});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'successful': successful});
    if (outcomeResult != null) {
      result.addAll({'outcomeResult': outcomeResult});
    }

    return result;
  }

  factory DecisionOutcomeDTO.fromMap(Map<String, dynamic> map) {
    return DecisionOutcomeDTO(
      successful: map['successful'],
      outcomeResult: map['outcomeResult'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DecisionOutcomeDTO.fromJson(String source) =>
      DecisionOutcomeDTO.fromMap(json.decode(source));
}
