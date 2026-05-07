// lib/features/itinerary/domain/entities/itinerary_item_entity.dart
import 'package:equatable/equatable.dart';

class ItineraryItemEntity extends Equatable {
  final String id;
  final String tripId;
  final String title;
  final String? description;
  final DateTime date;
  final String? time;
  final String? location;
  final String category;
  final bool isCompleted;
  final DateTime createdAt;
  final bool isSynced;

  const ItineraryItemEntity({
    required this.id,
    required this.tripId,
    required this.title,
    this.description,
    required this.date,
    this.time,
    this.location,
    required this.category,
    required this.isCompleted,
    required this.createdAt,
    required this.isSynced,
  });

  @override
  List<Object?> get props => [
        id,
        tripId,
        title,
        description,
        date,
        time,
        location,
        category,
        isCompleted,
        createdAt,
        isSynced,
      ];
}
