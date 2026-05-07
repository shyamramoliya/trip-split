// lib/features/expenses/data/models/expense_model.dart
import 'package:hive/hive.dart';
import '../../../../core/constants/hive_constants.dart';

part 'expense_model.g.dart';

@HiveType(typeId: HiveConstants.expenseTypeId)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String tripId;

  @HiveField(2)
  String title;

  @HiveField(3)
  double amount;

  @HiveField(4)
  String paidById;

  @HiveField(5)
  List<String> splitAmongIds;

  @HiveField(6)
  String category;

  @HiveField(7)
  DateTime date;

  @HiveField(8)
  String? notes;

  @HiveField(9)
  String currency;

  @HiveField(10)
  String splitType;

  @HiveField(11)
  DateTime createdAt;

  @HiveField(12)
  bool isSynced;

  ExpenseModel({
    required this.id,
    required this.tripId,
    required this.title,
    required this.amount,
    required this.paidById,
    required this.splitAmongIds,
    required this.category,
    required this.date,
    this.notes,
    this.currency = 'INR',
    this.splitType = 'equal',
    required this.createdAt,
    this.isSynced = false,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      paidById: json['paidById'] as String,
      splitAmongIds: List<String>.from(json['splitAmongIds'] as List),
      category: json['category'] as String,
      date: DateTime.parse(json['date'] as String),
      notes: json['notes'] as String?,
      currency: json['currency'] as String? ?? 'INR',
      splitType: json['splitType'] as String? ?? 'equal',
      createdAt: DateTime.parse(json['createdAt'] as String),
      isSynced: json['isSynced'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripId': tripId,
      'title': title,
      'amount': amount,
      'paidById': paidById,
      'splitAmongIds': splitAmongIds,
      'category': category,
      'date': date.toIso8601String(),
      'notes': notes,
      'currency': currency,
      'splitType': splitType,
      'createdAt': createdAt.toIso8601String(),
      'isSynced': isSynced,
    };
  }
}
