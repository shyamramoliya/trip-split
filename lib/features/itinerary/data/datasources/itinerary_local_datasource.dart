// lib/features/itinerary/data/datasources/itinerary_local_datasource.dart
import 'package:hive/hive.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/itinerary_item_model.dart';

abstract class ItineraryLocalDataSource {
  Stream<List<ItineraryItemModel>> watchTripItinerary(String tripId);
  Future<void> addItineraryItem(ItineraryItemModel item);
  Future<void> updateItineraryItem(ItineraryItemModel item);
  Future<void> deleteItineraryItem(String id);
}

class ItineraryLocalDataSourceImpl implements ItineraryLocalDataSource {
  final Box<ItineraryItemModel> _itineraryBox;

  ItineraryLocalDataSourceImpl(this._itineraryBox);

  @override
  Stream<List<ItineraryItemModel>> watchTripItinerary(String tripId) {
    return _itineraryBox.watch().map((_) => _itineraryBox.values.toList())
        .map((items) {
          final tripItems = items.where((item) => item.tripId == tripId).toList();
          tripItems.sort((a, b) {
            final dateComp = a.date.compareTo(b.date);
            if (dateComp != 0) return dateComp;
            return (a.time ?? '').compareTo(b.time ?? '');
          });
          return tripItems;
        });
  }

  @override
  Future<void> addItineraryItem(ItineraryItemModel item) async {
    try {
      await _itineraryBox.put(item.id, item);
    } catch (e) {
      throw StorageException('Failed to add itinerary item: $e');
    }
  }

  @override
  Future<void> updateItineraryItem(ItineraryItemModel item) async {
    try {
      await _itineraryBox.put(item.id, item);
    } catch (e) {
      throw StorageException('Failed to update itinerary item: $e');
    }
  }

  @override
  Future<void> deleteItineraryItem(String id) async {
    try {
      await _itineraryBox.delete(id);
    } catch (e) {
      throw StorageException('Failed to delete itinerary item: $e');
    }
  }
}
