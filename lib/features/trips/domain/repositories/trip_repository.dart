// lib/features/trips/domain/repositories/trip_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/participant_entity.dart';
import '../entities/trip_entity.dart';

abstract class TripRepository {
  Stream<List<TripEntity>> watchAllTrips();
  Future<Either<Failure, TripEntity>> getTripById(String id);
  Future<Either<Failure, void>> createTrip(TripEntity trip);
  Future<Either<Failure, void>> updateTrip(TripEntity trip);
  Future<Either<Failure, void>> deleteTrip(String id);
  Future<Either<Failure, void>> addParticipant(String tripId, ParticipantEntity participant);
  Future<Either<Failure, void>> removeParticipant(String tripId, String participantId);
}
