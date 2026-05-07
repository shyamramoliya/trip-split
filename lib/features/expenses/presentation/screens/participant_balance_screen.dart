// lib/features/expenses/presentation/screens/participant_balance_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../trips/presentation/providers/trip_provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/balance_card.dart';
import '../widgets/settlement_list.dart';

class ParticipantBalanceScreen extends ConsumerWidget {
  final String tripId;

  const ParticipantBalanceScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trip = ref.watch(tripByIdProvider(tripId));
    final balances = ref.watch(participantBalancesProvider(tripId));
    final settlements = ref.watch(simplifiedSettlementsProvider(tripId));

    if (trip == null) return const SizedBox();

    if (balances.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.account_balance_wallet,
        title: 'No balances yet',
        subtitle: 'Add expenses to see who owes who.',
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Individual Balances', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: trip.participants.length,
            itemBuilder: (context, index) {
              final p = trip.participants[index];
              final balance = balances[p.id] ?? 0.0;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: BalanceCard(participant: p, netBalance: balance, currency: trip.currency),
              );
            },
          ),
          
          const SizedBox(height: 32),
          Text('How to Settle Up', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('These suggested transfers minimize total transactions.', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          
          SettlementList(
            settlements: settlements,
            participants: trip.participants,
            currency: trip.currency,
            onSettle: (settlement) {
              // Create an "expense" that acts as a payment
              // to settle this debt.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settlement feature coming soon!')),
              );
            },
          ),
        ],
      ),
    );
  }
}
