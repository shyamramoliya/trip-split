// lib/features/expenses/presentation/providers/expense_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/app_providers.dart';
import '../../data/models/settlement_model.dart';
import '../../domain/entities/expense_entity.dart';
import '../../domain/usecases/simplify_settlements.dart';

part 'expense_provider.g.dart';

@riverpod
Stream<List<ExpenseEntity>> tripExpenses(TripExpensesRef ref, String tripId) {
  final repo = ref.watch(expenseRepositoryProvider);
  return repo.watchTripExpenses(tripId);
}

@riverpod
Map<String, double> participantBalances(ParticipantBalancesRef ref, String tripId) {
  final expensesStream = ref.watch(tripExpensesProvider(tripId));
  final expenses = expensesStream.value ?? [];
  return ExpenseSplitService.calculateNetBalances(expenses);
}

@riverpod
List<Settlement> simplifiedSettlements(SimplifiedSettlementsRef ref, String tripId) {
  final balances = ref.watch(participantBalancesProvider(tripId));
  return ExpenseSplitService.simplifySettlements(balances);
}

@riverpod
Map<String, double> expensesByCategory(ExpensesByCategoryRef ref, String tripId) {
  final expensesStream = ref.watch(tripExpensesProvider(tripId));
  final expenses = expensesStream.value ?? [];
  return ExpenseSplitService.getSpendByCategory(expenses);
}

@riverpod
double totalTripExpense(TotalTripExpenseRef ref, String tripId) {
  final expensesStream = ref.watch(tripExpensesProvider(tripId));
  final expenses = expensesStream.value ?? [];
  return ExpenseSplitService.getTotalGroupSpend(expenses);
}

@riverpod
class ExpenseNotifier extends _$ExpenseNotifier {
  @override
  void build() {}

  Future<void> addExpense(ExpenseEntity expense) async {
    final repo = ref.read(expenseRepositoryProvider);
    await repo.addExpense(expense);
  }

  Future<void> updateExpense(ExpenseEntity expense) async {
    final repo = ref.read(expenseRepositoryProvider);
    await repo.updateExpense(expense);
  }

  Future<void> deleteExpense(String id) async {
    final repo = ref.read(expenseRepositoryProvider);
    await repo.deleteExpense(id);
  }
}
