// lib/features/itinerary/presentation/widgets/itinerary_timeline.dart
import 'package:flutter/material.dart';
import '../../domain/entities/itinerary_item_entity.dart';
import 'itinerary_item_card.dart';

class ItineraryTimeline extends StatelessWidget {
  final List<ItineraryItemEntity> items;
  final Function(ItineraryItemEntity, bool) onToggleCompletion;
  final Function(ItineraryItemEntity) onDelete;

  const ItineraryTimeline({
    super.key,
    required this.items,
    required this.onToggleCompletion,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No activities for this day.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: Key(item.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) => onDelete(item),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline line & dot
                SizedBox(
                  width: 32,
                  child: Column(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.only(top: 24),
                        decoration: BoxDecoration(
                          color: item.isCompleted ? Colors.grey : Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      if (index < items.length - 1)
                        Container(
                          width: 2,
                          height: 80, // Approximate height to connect
                          color: Colors.grey.withOpacity(0.3),
                        ),
                    ],
                  ),
                ),
                // Card
                Expanded(
                  child: ItineraryItemCard(
                    item: item,
                    onToggleCompletion: (val) => onToggleCompletion(item, val),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
