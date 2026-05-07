// lib/features/expenses/data/models/settlement_model.dart
class Settlement {
  final String fromParticipantId;
  final String toParticipantId;
  final double amount;
  bool isSettled;

  Settlement({
    required this.fromParticipantId,
    required this.toParticipantId,
    required this.amount,
    this.isSettled = false,
  });

  @override
  String toString() => 'Settlement(from: $fromParticipantId, to: $toParticipantId, amount: $amount, settled: $isSettled)';
}
