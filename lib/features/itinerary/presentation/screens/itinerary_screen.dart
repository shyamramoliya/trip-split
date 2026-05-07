// lib/features/itinerary/presentation/screens/itinerary_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../domain/entities/itinerary_item_entity.dart';
import '../providers/itinerary_provider.dart';
import '../widgets/itinerary_timeline.dart';

class ItineraryScreen extends ConsumerStatefulWidget {
  final String tripId;

  const ItineraryScreen({super.key, required this.tripId});

  @override
  ConsumerState<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends ConsumerState<ItineraryScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final itineraryAsync = ref.watch(tripItineraryProvider(widget.tripId));

    return Column(
      children: [
        // Calendar strip placeholder (a real app would use a date strip package)
        Container(
          height: 80,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 14,
            itemBuilder: (context, index) {
              final date = DateTime.now().add(Duration(days: index - 2));
              final isSelected = date.day == _selectedDate.day && date.month == _selectedDate.month;
              
              return GestureDetector(
                onTap: () => setState(() => _selectedDate = date),
                child: Container(
                  width: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.2)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _getShortWeekday(date.weekday),
                        style: TextStyle(
                          color: isSelected ? Colors.white70 : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        
        Expanded(
          child: itineraryAsync.when(
            data: (items) {
              final dayItems = items.where((item) => 
                item.date.year == _selectedDate.year && 
                item.date.month == _selectedDate.month && 
                item.date.day == _selectedDate.day
              ).toList();

              if (dayItems.isEmpty) {
                return EmptyStateWidget(
                  icon: Icons.event_busy,
                  title: 'No activities',
                  subtitle: 'Nothing planned for this day.',
                  actionLabel: 'Add Activity',
                  onAction: () => _showAddActivityDialog(context),
                );
              }

              return ItineraryTimeline(
                items: dayItems,
                onToggleCompletion: (item, val) {
                  final updated = ItineraryItemEntity(
                    id: item.id,
                    tripId: item.tripId,
                    title: item.title,
                    description: item.description,
                    date: item.date,
                    time: item.time,
                    location: item.location,
                    category: item.category,
                    isCompleted: val,
                    createdAt: item.createdAt,
                    isSynced: false,
                  );
                  ref.read(itineraryNotifierProvider.notifier).updateItineraryItem(updated);
                },
                onDelete: (item) {
                  ref.read(itineraryNotifierProvider.notifier).deleteItineraryItem(item.id);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text('Error: $e')),
          ),
        ),
      ],
    );
  }

  String _getShortWeekday(int weekday) {
    switch (weekday) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return '';
    }
  }

  void _showAddActivityDialog(BuildContext context) {
    // In a full implementation, this would be a full bottom sheet with form.
    // We add a simple mock item for demonstration of the data flow.
    final newItem = ItineraryItemEntity(
      id: const Uuid().v4(),
      tripId: widget.tripId,
      title: 'Visit Museum',
      date: _selectedDate,
      time: '10:00 AM',
      category: 'sightseeing',
      isCompleted: false,
      createdAt: DateTime.now(),
      isSynced: false,
    );
    ref.read(itineraryNotifierProvider.notifier).addItineraryItem(newItem);
  }
}
