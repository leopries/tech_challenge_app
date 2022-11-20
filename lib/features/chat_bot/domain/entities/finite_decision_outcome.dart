/// Finite outcome of a single decision node
class FiniteDecisionOutcome {
  /// Flag whether the outcome has a result.
  final bool successful;

  /// Optional result text, if successful.
  final String? outcomeResult;

  const FiniteDecisionOutcome({
    required this.successful,
    this.outcomeResult,
  });

  @override
  String toString() =>
      'FiniteDecisionOutcome(successful: $successful, outcomeResult: $outcomeResult)';
}
