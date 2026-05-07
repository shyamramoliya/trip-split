// lib/features/expenses/data/datasources/expense_local_datasource.dart
import 'package:hive/hive.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/expense_model.dart';

abstract class ExpenseLocalDataSource {
  Stream<List<ExpenseModel>> watchTripExpenses(String tripId);
  Future<void> addExpense(ExpenseModel expense);
  Future<void> updateExpense(ExpenseModel expense);
  Future<void> deleteExpense(String id);
}

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final Box<ExpenseModel> _expensesBox;

  ExpenseLocalDataSourceImpl(this._expensesBox);

  @override
  Stream<List<ExpenseModel>> watchTripExpenses(String tripId) {
    return _expensesBox.watch().map((_) => _expensesBox.values.toList())
        .map((items) {
          final tripExpenses = items.where((e) => e.tripId == tripId).toList();
          tripExpenses.sort((a, b) => b.date.compareTo(a.date));
          return tripExpenses;
        });
  }

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    try {
      await _expensesBox.put(expense.id, expense);
    } catch (e) {
      throw StorageException('Failed to add expense: $e');
    }
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    try {
      await _expensesBox.put(expense.id, expense);
    } catch (e) {
      throw StorageException('Failed to update expense: $e');
    }
  }

  @override
  Future<void> deleteExpense(String id) async {
    try {
      await _expensesBox.delete(id);
    } catch (e) {
      throw StorageException('Failed to delete expense: $e');
    }
  }
}
