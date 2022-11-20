import 'dart:convert';

class DecisionOptionDescriptionDTO {
  final String text;

  const DecisionOptionDescriptionDTO({required this.text});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'text': text});

    return result;
  }

  factory DecisionOptionDescriptionDTO.fromMap(Map<String, dynamic> map) {
    return DecisionOptionDescriptionDTO(
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DecisionOptionDescriptionDTO.fromJson(String source) =>
      DecisionOptionDescriptionDTO.fromMap(json.decode(source));
}
