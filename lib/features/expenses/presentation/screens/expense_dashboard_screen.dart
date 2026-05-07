// lib/features/expenses/presentation/screens/expense_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../trips/presentation/providers/trip_provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_card.dart';
import '../widgets/expense_chart.dart';

class ExpenseDashboardScreen extends ConsumerWidget {
  final String tripId;

  const ExpenseDashboardScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(tripExpensesProvider(tripId));
    final categorySpend = ref.watch(expensesByCategoryProvider(tripId));
    final trip = ref.watch(tripByIdProvider(tripId));

    if (trip == null) return const SizedBox();

    return expensesAsync.when(
      data: (expenses) {
        if (expenses.isEmpty) {
          return const EmptyStateWidget(
            icon: Icons.receipt_long,
            title: 'No expenses yet',
            subtitle: 'Add expenses to start splitting costs with your group.',
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Spend by Category', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              ExpenseChart(categoryAmounts: categorySpend, currency: trip.currency),
              
              const SizedBox(height: 32),
              Text('Recent Expenses', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: expenses.length > 5 ? 5 : expenses.length, // show last 5
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  final payer = trip.participants.firstWhere(
                    (p) => p.id == expense.paidById, 
                    orElse: () => trip.participants.first
                  );
                  return ExpenseCard(
                    expense: expense,
                    payer: payer,
                    onTap: () {
                      // Navigate to detail
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }
}
