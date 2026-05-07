// lib/features/itinerary/presentation/widgets/itinerary_item_card.dart
import 'package:flutter/material.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/itinerary_item_entity.dart';

class ItineraryItemCard extends StatelessWidget {
  final ItineraryItemEntity item;
  final Function(bool) onToggleCompletion;

  const ItineraryItemCard({
    super.key,
    required this.item,
    required this.onToggleCompletion,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: item.isCompleted ? Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5) : null,
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _getCategoryColor(item.category).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getCategoryIcon(item.category),
              color: _getCategoryColor(item.category),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: item.isCompleted ? TextDecoration.lineThrough : null,
                        color: item.isCompleted ? Colors.grey : null,
                      ),
                ),
                if (item.time != null || item.location != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (item.time != null) ...[
                        const Icon(Icons.access_time, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(item.time!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        if (item.location != null) const SizedBox(width: 12),
                      ],
                      if (item.location != null) ...[
                        const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            item.location!,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
                if (item.description != null && item.description!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    item.description!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ],
            ),
          ),
          Checkbox(
            value: item.isCompleted,
            onChanged: (val) => onToggleCompletion(val ?? false),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'transport': return Icons.directions_transit;
      case 'food': return Icons.restaurant;
      case 'hotel': return Icons.hotel;
      case 'sightseeing': return Icons.attractions;
      default: return Icons.event;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'transport': return Colors.blue;
      case 'food': return Colors.orange;
      case 'hotel': return Colors.purple;
      case 'sightseeing': return Colors.green;
      default: return Colors.grey;
    }
  }
}
