// lib/features/itinerary/data/models/itinerary_item_model.dart
import 'package:hive/hive.dart';
import '../../../../core/constants/hive_constants.dart';

part 'itinerary_item_model.g.dart';

@HiveType(typeId: HiveConstants.itineraryItemTypeId)
class ItineraryItemModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String tripId;

  @HiveField(2)
  String title;

  @HiveField(3)
  String? description;

  @HiveField(4)
  DateTime date;

  @HiveField(5)
  String? time;

  @HiveField(6)
  String? location;

  @HiveField(7)
  String category;

  @HiveField(8)
  bool isCompleted;

  @HiveField(9)
  DateTime createdAt;

  @HiveField(10)
  bool isSynced;

  ItineraryItemModel({
    required this.id,
    required this.tripId,
    required this.title,
    this.description,
    required this.date,
    this.time,
    this.location,
    required this.category,
    this.isCompleted = false,
    required this.createdAt,
    this.isSynced = false,
  });

  factory ItineraryItemModel.fromJson(Map<String, dynamic> json) {
    return ItineraryItemModel(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String?,
      location: json['location'] as String?,
      category: json['category'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isSynced: json['isSynced'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripId': tripId,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'time': time,
      'location': location,
      'category': category,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'isSynced': isSynced,
    };
  }
}
