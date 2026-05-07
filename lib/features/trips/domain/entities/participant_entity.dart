// lib/features/trips/domain/entities/participant_entity.dart
import 'package:equatable/equatable.dart';

class ParticipantEntity extends Equatable {
  final String id;
  final String name;
  final String? email;
  final String? avatarUrl;
  final String colorHex;

  const ParticipantEntity({
    required this.id,
    required this.name,
    this.email,
    this.avatarUrl,
    required this.colorHex,
  });

  @override
  List<Object?> get props => [id, name, email, avatarUrl, colorHex];
}
