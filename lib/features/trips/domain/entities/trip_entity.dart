// lib/features/trips/domain/entities/trip_entity.dart
import 'package:equatable/equatable.dart';
import 'participant_entity.dart';

class TripEntity extends Equatable {
  final String id;
  final String name;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> participantIds;
  final List<ParticipantEntity> participants;
  final String? coverImageUrl;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  final String? firebaseDocId;

  const TripEntity({
    required this.id,
    required this.name,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.participantIds,
    required this.participants,
    this.coverImageUrl,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
    this.firebaseDocId,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        destination,
        startDate,
        endDate,
        participantIds,
        participants,
        coverImageUrl,
        currency,
        createdAt,
        updatedAt,
        isSynced,
        firebaseDocId,
      ];
}
