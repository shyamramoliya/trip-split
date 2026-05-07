// lib/features/expenses/domain/repositories/expense_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/expense_entity.dart';

abstract class ExpenseRepository {
  Stream<List<ExpenseEntity>> watchTripExpenses(String tripId);
  Future<Either<Failure, void>> addExpense(ExpenseEntity expense);
  Future<Either<Failure, void>> updateExpense(ExpenseEntity expense);
  Future<Either<Failure, void>> deleteExpense(String id);
}
