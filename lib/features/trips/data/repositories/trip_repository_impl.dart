// lib/features/trips/data/repositories/trip_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/participant_entity.dart';
import '../../domain/entities/trip_entity.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/trip_local_datasource.dart';
import '../models/participant_mapper.dart';
import '../models/trip_mapper.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource localDataSource;

  TripRepositoryImpl({required this.localDataSource});

  @override
  Stream<List<TripEntity>> watchAllTrips() {
    return localDataSource.watchAllTrips().map(
          (models) => models.map((m) => TripMapper.toEntity(m)).toList(),
        );
  }

  @override
  Future<Either<Failure, TripEntity>> getTripById(String id) async {
    try {
      final trip = await localDataSource.getTripById(id);
      if (trip == null) return const Left(NotFoundFailure('Trip not found'));
      return Right(TripMapper.toEntity(trip));
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, void>> createTrip(TripEntity trip) async {
    try {
      final model = TripMapper.toModel(trip);
      model.isSynced = false;
      await localDataSource.createTrip(model);
      // TODO: Add to sync queue
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTrip(TripEntity trip) async {
    try {
      final model = TripMapper.toModel(trip);
      model.isSynced = false;
      await localDataSource.updateTrip(model);
      // TODO: Add to sync queue
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTrip(String id) async {
    try {
      await localDataSource.deleteTrip(id);
      // TODO: Add delete operation to sync queue
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addParticipant(String tripId, ParticipantEntity participant) async {
    try {
      final model = ParticipantMapper.toModel(participant);
      await localDataSource.addParticipant(tripId, model);
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeParticipant(String tripId, String participantId) async {
    try {
      await localDataSource.removeParticipant(tripId, participantId);
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure());
    }
  }
}
