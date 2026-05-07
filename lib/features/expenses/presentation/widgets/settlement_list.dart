// lib/features/expenses/presentation/widgets/settlement_list.dart
import 'package:flutter/material.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/app_button.dart';
import '../../data/models/settlement_model.dart';
import '../../../trips/domain/entities/participant_entity.dart';

class SettlementList extends StatelessWidget {
  final List<Settlement> settlements;
  final List<ParticipantEntity> participants;
  final Function(Settlement) onSettle;
  final String currency;

  const SettlementList({
    super.key,
    required this.settlements,
    required this.participants,
    required this.onSettle,
    this.currency = 'INR',
  });

  @override
  Widget build(BuildContext context) {
    if (settlements.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text('All settled up! No one owes anything.'),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: settlements.length,
      itemBuilder: (context, index) {
        final settlement = settlements[index];
        final from = participants.firstWhere((p) => p.id == settlement.fromParticipantId, orElse: () => ParticipantEntity(id: 'unknown', name: 'Unknown', colorHex: '000000'));
        final to = participants.firstWhere((p) => p.id == settlement.toParticipantId, orElse: () => ParticipantEntity(id: 'unknown', name: 'Unknown', colorHex: '000000'));

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(text: '${from.name} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                            const TextSpan(text: 'pays '),
                            TextSpan(text: to.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        CurrencyFormatter.format(settlement.amount, currency: currency),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                AppButton(
                  label: 'Settle',
                  variant: AppButtonVariant.outlined,
                  onPressed: () => onSettle(settlement),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
