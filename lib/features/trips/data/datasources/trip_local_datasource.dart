// lib/features/trips/data/datasources/trip_local_datasource.dart
import 'package:hive/hive.dart';
import '../../../../core/constants/hive_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/trip_model.dart';
import '../models/participant_model.dart';

abstract class TripLocalDataSource {
  Stream<List<TripModel>> watchAllTrips();
  Future<TripModel?> getTripById(String id);
  Future<void> createTrip(TripModel trip);
  Future<void> updateTrip(TripModel trip);
  Future<void> deleteTrip(String id);
  Future<void> addParticipant(String tripId, ParticipantModel participant);
  Future<void> removeParticipant(String tripId, String participantId);
}

class TripLocalDataSourceImpl implements TripLocalDataSource {
  final Box<TripModel> _tripsBox;

  TripLocalDataSourceImpl(this._tripsBox);

  @override
  Stream<List<TripModel>> watchAllTrips() {
    return _tripsBox.watch().map((event) => _tripsBox.values.toList())
        .map((trips) {
          final sorted = trips.toList();
          sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return sorted;
        });
  }

  @override
  Future<TripModel?> getTripById(String id) async {
    try {
      return _tripsBox.get(id);
    } catch (e) {
      throw StorageException('Failed to get trip by id: $e');
    }
  }

  @override
  Future<void> createTrip(TripModel trip) async {
    try {
      await _tripsBox.put(trip.id, trip);
    } catch (e) {
      throw StorageException('Failed to create trip: $e');
    }
  }

  @override
  Future<void> updateTrip(TripModel trip) async {
    try {
      await _tripsBox.put(trip.id, trip);
    } catch (e) {
      throw StorageException('Failed to update trip: $e');
    }
  }

  @override
  Future<void> deleteTrip(String id) async {
    try {
      await _tripsBox.delete(id);
    } catch (e) {
      throw StorageException('Failed to delete trip: $e');
    }
  }

  @override
  Future<void> addParticipant(String tripId, ParticipantModel participant) async {
    try {
      final trip = _tripsBox.get(tripId);
      if (trip == null) throw StorageException('Trip not found');
      
      if (!trip.participantIds.contains(participant.id)) {
        trip.participantIds.add(participant.id);
        trip.participants.add(participant);
        trip.updatedAt = DateTime.now();
        trip.isSynced = false;
        await trip.save();
      }
    } catch (e) {
      throw StorageException('Failed to add participant: $e');
    }
  }

  @override
  Future<void> removeParticipant(String tripId, String participantId) async {
    try {
      final trip = _tripsBox.get(tripId);
      if (trip == null) throw StorageException('Trip not found');
      
      trip.participantIds.remove(participantId);
      trip.participants.removeWhere((p) => p.id == participantId);
      trip.updatedAt = DateTime.now();
      trip.isSynced = false;
      await trip.save();
    } catch (e) {
      throw StorageException('Failed to remove participant: $e');
    }
  }
}
