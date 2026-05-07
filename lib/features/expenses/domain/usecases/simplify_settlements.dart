// lib/features/expenses/domain/usecases/simplify_settlements.dart
import '../../data/models/settlement_model.dart';
import '../entities/expense_entity.dart';

class ExpenseSplitService {
  /// Calculates the net balance of each participant.
  /// Positive balance means they are owed money (Creditor).
  /// Negative balance means they owe money (Debtor).
  static Map<String, double> calculateNetBalances(List<ExpenseEntity> expenses) {
    final Map<String, double> balances = {};

    for (final expense in expenses) {
      // Payer gets credited (+ amount)
      balances[expense.paidById] = (balances[expense.paidById] ?? 0.0) + expense.amount;

      if (expense.splitAmongIds.isEmpty) continue;

      // Split evenly among all participants in splitAmongIds
      final double splitAmount = expense.amount / expense.splitAmongIds.length;

      // Each sharer gets debited (- amount)
      for (final personId in expense.splitAmongIds) {
        balances[personId] = (balances[personId] ?? 0.0) - splitAmount;
      }
    }

    // Clean up small floating point inaccuracies
    balances.forEach((key, value) {
      if (value.abs() < 0.01) balances[key] = 0.0;
    });

    return balances;
  }

  /// Implements a greedy algorithm to simplify debts and minimize transactions.
  static List<Settlement> simplifySettlements(Map<String, double> balances) {
    final List<Settlement> settlements = [];

    // Separate into debtors (negative) and creditors (positive)
    final List<MapEntry<String, double>> debtors = balances.entries
        .where((e) => e.value < -0.01)
        .toList()
      ..sort((a, b) => a.value.compareTo(b.value)); // Most negative first

    final List<MapEntry<String, double>> creditors = balances.entries
        .where((e) => e.value > 0.01)
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value)); // Most positive first

    int i = 0; // index for debtors
    int j = 0; // index for creditors

    while (i < debtors.length && j < creditors.length) {
      final debtorId = debtors[i].key;
      final debtorAmount = debtors[i].value.abs();
      
      final creditorId = creditors[j].key;
      final creditorAmount = creditors[j].value;

      final double settleAmount = debtorAmount < creditorAmount ? debtorAmount : creditorAmount;

      settlements.add(Settlement(
        fromParticipantId: debtorId,
        toParticipantId: creditorId,
        amount: double.parse(settleAmount.toStringAsFixed(2)),
      ));

      // Update remaining balances
      debtors[i] = MapEntry(debtorId, -(debtorAmount - settleAmount));
      creditors[j] = MapEntry(creditorId, creditorAmount - settleAmount);

      if (debtors[i].value.abs() < 0.01) i++;
      if (creditors[j].value < 0.01) j++;
    }

    return settlements;
  }

  static double getTotalGroupSpend(List<ExpenseEntity> expenses) {
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  static double getMyShare(String participantId, List<ExpenseEntity> expenses) {
    double myShare = 0.0;
    for (final expense in expenses) {
      if (expense.splitAmongIds.contains(participantId)) {
        myShare += expense.amount / expense.splitAmongIds.length;
      }
    }
    return myShare;
  }

  static Map<String, double> getSpendByCategory(List<ExpenseEntity> expenses) {
    final Map<String, double> categorySpend = {};
    for (final expense in expenses) {
      categorySpend[expense.category] = (categorySpend[expense.category] ?? 0.0) + expense.amount;
    }
    return categorySpend;
  }

  static List<ExpenseEntity> getExpensesByParticipant(String participantId, List<ExpenseEntity> expenses) {
    return expenses.where((e) => e.paidById == participantId || e.splitAmongIds.contains(participantId)).toList();
  }
}
