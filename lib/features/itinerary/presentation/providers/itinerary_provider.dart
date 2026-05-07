// lib/features/itinerary/presentation/providers/itinerary_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/app_providers.dart';
import '../../domain/entities/itinerary_item_entity.dart';

part 'itinerary_provider.g.dart';

@riverpod
Stream<List<ItineraryItemEntity>> tripItinerary(TripItineraryRef ref, String tripId) {
  final repo = ref.watch(itineraryRepositoryProvider);
  return repo.watchTripItinerary(tripId);
}

@riverpod
class ItineraryNotifier extends _$ItineraryNotifier {
  @override
  void build() {}

  Future<void> addItineraryItem(ItineraryItemEntity item) async {
    final repo = ref.read(itineraryRepositoryProvider);
    await repo.addItineraryItem(item);
  }

  Future<void> updateItineraryItem(ItineraryItemEntity item) async {
    final repo = ref.read(itineraryRepositoryProvider);
    await repo.updateItineraryItem(item);
  }

  Future<void> deleteItineraryItem(String id) async {
    final repo = ref.read(itineraryRepositoryProvider);
    await repo.deleteItineraryItem(id);
  }
}
