// lib/features/trips/presentation/providers/trip_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/app_providers.dart';
import '../../domain/entities/participant_entity.dart';
import '../../domain/entities/trip_entity.dart';

part 'trip_provider.g.dart';

@riverpod
Stream<List<TripEntity>> allTrips(AllTripsRef ref) {
  final repo = ref.watch(tripRepositoryProvider);
  return repo.watchAllTrips();
}

@riverpod
TripEntity? tripById(TripByIdRef ref, String tripId) {
  final tripsStream = ref.watch(allTripsProvider);
  final trips = tripsStream.value;
  if (trips == null) return null;
  
  try {
    return trips.firstWhere((trip) => trip.id == tripId);
  } catch (e) {
    return null;
  }
}

@riverpod
class TripNotifier extends _$TripNotifier {
  @override
  void build() {}

  Future<void> createTrip(TripEntity trip) async {
    final repo = ref.read(tripRepositoryProvider);
    await repo.createTrip(trip);
  }

  Future<void> updateTrip(TripEntity trip) async {
    final repo = ref.read(tripRepositoryProvider);
    await repo.updateTrip(trip);
  }

  Future<void> deleteTrip(String id) async {
    final repo = ref.read(tripRepositoryProvider);
    await repo.deleteTrip(id);
  }

  Future<void> addParticipant(String tripId, ParticipantEntity participant) async {
    final repo = ref.read(tripRepositoryProvider);
    await repo.addParticipant(tripId, participant);
  }

  Future<void> removeParticipant(String tripId, String participantId) async {
    final repo = ref.read(tripRepositoryProvider);
    await repo.removeParticipant(tripId, participantId);
  }
}
