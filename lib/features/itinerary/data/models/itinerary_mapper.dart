// lib/features/itinerary/data/models/itinerary_mapper.dart
import '../../domain/entities/itinerary_item_entity.dart';
import 'itinerary_item_model.dart';

class ItineraryMapper {
  static ItineraryItemEntity toEntity(ItineraryItemModel model) {
    return ItineraryItemEntity(
      id: model.id,
      tripId: model.tripId,
      title: model.title,
      description: model.description,
      date: model.date,
      time: model.time,
      location: model.location,
      category: model.category,
      isCompleted: model.isCompleted,
      createdAt: model.createdAt,
      isSynced: model.isSynced,
    );
  }

  static ItineraryItemModel toModel(ItineraryItemEntity entity) {
    return ItineraryItemModel(
      id: entity.id,
      tripId: entity.tripId,
      title: entity.title,
      description: entity.description,
      date: entity.date,
      time: entity.time,
      location: entity.location,
      category: entity.category,
      isCompleted: entity.isCompleted,
      createdAt: entity.createdAt,
      isSynced: entity.isSynced,
    );
  }
}
