/// Description of an option
class DecisionOptionDescription {
  /// textual description of the text, might be extended with further contents
  final String text;

  const DecisionOptionDescription({required this.text});

  @override
  String toString() => 'DecisionOptionDescription(text: $text)';
}
