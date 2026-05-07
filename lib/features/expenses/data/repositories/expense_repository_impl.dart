// lib/features/expenses/data/repositories/expense_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/expense_entity.dart';
import '../../domain/repositories/expense_repository.dart';
import '../datasources/expense_local_datasource.dart';
import '../models/expense_mapper.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;

  ExpenseRepositoryImpl({required this.localDataSource});

  @override
  Stream<List<ExpenseEntity>> watchTripExpenses(String tripId) {
    return localDataSource.watchTripExpenses(tripId).map(
          (models) => models.map((m) => ExpenseMapper.toEntity(m)).toList(),
        );
  }

  @override
  Future<Either<Failure, void>> addExpense(ExpenseEntity expense) async {
    try {
      final model = ExpenseMapper.toModel(expense);
      model.isSynced = false;
      await localDataSource.addExpense(model);
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateExpense(ExpenseEntity expense) async {
    try {
      final model = ExpenseMapper.toModel(expense);
      model.isSynced = false;
      await localDataSource.updateExpense(model);
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String id) async {
    try {
      await localDataSource.deleteExpense(id);
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure());
    }
  }
}
