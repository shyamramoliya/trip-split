// lib/features/trips/data/models/trip_model.dart
import 'package:hive/hive.dart';
import '../../../../core/constants/hive_constants.dart';
import 'participant_model.dart';

part 'trip_model.g.dart';

@HiveType(typeId: HiveConstants.tripTypeId)
class TripModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String destination;

  @HiveField(3)
  DateTime startDate;

  @HiveField(4)
  DateTime endDate;

  @HiveField(5)
  List<String> participantIds;

  @HiveField(6)
  List<ParticipantModel> participants;

  @HiveField(7)
  String? coverImageUrl;

  @HiveField(8)
  String currency;

  @HiveField(9)
  DateTime createdAt;

  @HiveField(10)
  DateTime updatedAt;

  @HiveField(11)
  bool isSynced;

  @HiveField(12)
  String? firebaseDocId;

  TripModel({
    required this.id,
    required this.name,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.participantIds,
    required this.participants,
    this.coverImageUrl,
    this.currency = 'INR',
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = false,
    this.firebaseDocId,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] as String,
      name: json['name'] as String,
      destination: json['destination'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      participantIds: List<String>.from(json['participantIds'] as List),
      participants: (json['participants'] as List)
          .map((e) => ParticipantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      coverImageUrl: json['coverImageUrl'] as String?,
      currency: json['currency'] as String? ?? 'INR',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isSynced: json['isSynced'] as bool? ?? false,
      firebaseDocId: json['firebaseDocId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'destination': destination,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'participantIds': participantIds,
      'participants': participants.map((e) => e.toJson()).toList(),
      'coverImageUrl': coverImageUrl,
      'currency': currency,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isSynced': isSynced,
      'firebaseDocId': firebaseDocId,
    };
  }
}
