// lib/features/expenses/domain/entities/expense_entity.dart
import 'package:equatable/equatable.dart';

class ExpenseEntity extends Equatable {
  final String id;
  final String tripId;
  final String title;
  final double amount;
  final String paidById;
  final List<String> splitAmongIds;
  final String category;
  final DateTime date;
  final String? notes;
  final String currency;
  final String splitType;
  final DateTime createdAt;
  final bool isSynced;

  const ExpenseEntity({
    required this.id,
    required this.tripId,
    required this.title,
    required this.amount,
    required this.paidById,
    required this.splitAmongIds,
    required this.category,
    required this.date,
    this.notes,
    required this.currency,
    required this.splitType,
    required this.createdAt,
    required this.isSynced,
  });

  @override
  List<Object?> get props => [
        id,
        tripId,
        title,
        amount,
        paidById,
        splitAmongIds,
        category,
        date,
        notes,
        currency,
        splitType,
        createdAt,
        isSynced,
      ];
}
