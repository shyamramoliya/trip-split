// lib/features/expenses/presentation/widgets/expense_card.dart
import 'package:flutter/material.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/expense_entity.dart';
import '../../../trips/domain/entities/participant_entity.dart';

class ExpenseCard extends StatelessWidget {
  final ExpenseEntity expense;
  final ParticipantEntity payer;
  final VoidCallback onTap;

  const ExpenseCard({
    super.key,
    required this.expense,
    required this.payer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_getCategoryIcon(expense.category), color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Paid by ${payer.name} • ${DateFormatter.formatRelative(expense.date)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            CurrencyFormatter.format(expense.amount, currency: expense.currency),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food': return Icons.restaurant;
      case 'transport': return Icons.directions_car;
      case 'hotel': return Icons.hotel;
      case 'activity': return Icons.local_activity;
      case 'shopping': return Icons.shopping_bag;
      default: return Icons.receipt;
    }
  }
}
