// lib/features/trips/data/models/participant_mapper.dart
import '../../domain/entities/participant_entity.dart';
import 'participant_model.dart';

class ParticipantMapper {
  static ParticipantEntity toEntity(ParticipantModel model) {
    return ParticipantEntity(
      id: model.id,
      name: model.name,
      email: model.email,
      avatarUrl: model.avatarUrl,
      colorHex: model.colorHex,
    );
  }

  static ParticipantModel toModel(ParticipantEntity entity) {
    return ParticipantModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      avatarUrl: entity.avatarUrl,
      colorHex: entity.colorHex,
    );
  }
}
