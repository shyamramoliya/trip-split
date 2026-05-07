// lib/features/trips/data/models/trip_mapper.dart
import '../../domain/entities/trip_entity.dart';
import 'participant_mapper.dart';
import 'trip_model.dart';

class TripMapper {
  static TripEntity toEntity(TripModel model) {
    return TripEntity(
      id: model.id,
      name: model.name,
      destination: model.destination,
      startDate: model.startDate,
      endDate: model.endDate,
      participantIds: model.participantIds,
      participants: model.participants.map((p) => ParticipantMapper.toEntity(p)).toList(),
      coverImageUrl: model.coverImageUrl,
      currency: model.currency,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      isSynced: model.isSynced,
      firebaseDocId: model.firebaseDocId,
    );
  }

  static TripModel toModel(TripEntity entity) {
    return TripModel(
      id: entity.id,
      name: entity.name,
      destination: entity.destination,
      startDate: entity.startDate,
      endDate: entity.endDate,
      participantIds: entity.participantIds,
      participants: entity.participants.map((p) => ParticipantMapper.toModel(p)).toList(),
      coverImageUrl: entity.coverImageUrl,
      currency: entity.currency,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isSynced: entity.isSynced,
      firebaseDocId: entity.firebaseDocId,
    );
  }
}
