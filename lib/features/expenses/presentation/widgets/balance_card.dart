// lib/features/expenses/presentation/widgets/balance_card.dart
import 'package:flutter/material.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../trips/domain/entities/participant_entity.dart';
import '../../../trips/presentation/widgets/participant_chip.dart';

class BalanceCard extends StatelessWidget {
  final ParticipantEntity participant;
  final double netBalance;
  final String currency;

  const BalanceCard({
    super.key,
    required this.participant,
    required this.netBalance,
    this.currency = 'INR',
  });

  @override
  Widget build(BuildContext context) {
    final isOwed = netBalance > 0.01;
    final isSettled = netBalance.abs() <= 0.01;
    
    Color statusColor;
    String statusText;

    if (isSettled) {
      statusColor = Colors.grey;
      statusText = 'Settled up';
    } else if (isOwed) {
      statusColor = Colors.green;
      statusText = 'Gets back';
    } else {
      statusColor = Colors.red;
      statusText = 'Owes';
    }

    return AppCard(
      child: Row(
        children: [
          ParticipantAvatar(participant: participant, size: 48),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(participant.name, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(statusText, style: TextStyle(color: statusColor, fontSize: 12)),
              ],
            ),
          ),
          if (!isSettled)
            Text(
              CurrencyFormatter.format(netBalance.abs(), currency: currency),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
            )
          else
            const Icon(Icons.check_circle, color: Colors.grey),
        ],
      ),
    );
  }
}
