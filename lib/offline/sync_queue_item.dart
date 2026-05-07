// lib/offline/sync_queue_item.dart
import 'package:hive/hive.dart';
import '../core/constants/hive_constants.dart';

part 'sync_queue_item.g.dart';

@HiveType(typeId: HiveConstants.syncQueueItemTypeId)
class SyncQueueItem extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String operation; // "create", "update", "delete"

  @HiveField(2)
  String entityType; // "trip", "itinerary", "expense"

  @HiveField(3)
  String entityId;

  @HiveField(4)
  Map<String, dynamic> payload;

  @HiveField(5)
  DateTime timestamp;

  @HiveField(6)
  int retryCount;

  SyncQueueItem({
    required this.id,
    required this.operation,
    required this.entityType,
    required this.entityId,
    required this.payload,
    required this.timestamp,
    this.retryCount = 0,
  });
}
