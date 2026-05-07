// lib/features/expenses/data/models/expense_mapper.dart
import '../../domain/entities/expense_entity.dart';
import 'expense_model.dart';

class ExpenseMapper {
  static ExpenseEntity toEntity(ExpenseModel model) {
    return ExpenseEntity(
      id: model.id,
      tripId: model.tripId,
      title: model.title,
      amount: model.amount,
      paidById: model.paidById,
      splitAmongIds: model.splitAmongIds,
      category: model.category,
      date: model.date,
      notes: model.notes,
      currency: model.currency,
      splitType: model.splitType,
      createdAt: model.createdAt,
      isSynced: model.isSynced,
    );
  }

  static ExpenseModel toModel(ExpenseEntity entity) {
    return ExpenseModel(
      id: entity.id,
      tripId: entity.tripId,
      title: entity.title,
      amount: entity.amount,
      paidById: entity.paidById,
      splitAmongIds: entity.splitAmongIds,
      category: entity.category,
      date: entity.date,
      notes: entity.notes,
      currency: entity.currency,
      splitType: entity.splitType,
      createdAt: entity.createdAt,
      isSynced: entity.isSynced,
    );
  }
}
