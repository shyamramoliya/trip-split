// lib/features/trips/data/models/participant_model.dart
import 'package:hive/hive.dart';
import '../../../../core/constants/hive_constants.dart';

part 'participant_model.g.dart';

@HiveType(typeId: HiveConstants.participantTypeId)
class ParticipantModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? avatarUrl;

  @HiveField(4)
  String colorHex;

  ParticipantModel({
    required this.id,
    required this.name,
    this.email,
    this.avatarUrl,
    required this.colorHex,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      colorHex: json['colorHex'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'colorHex': colorHex,
    };
  }
}
