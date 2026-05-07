// lib/features/itinerary/data/repositories/itinerary_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/itinerary_item_entity.dart';
import '../../domain/repositories/itinerary_repository.dart';
import '../datasources/itinerary_local_datasource.dart';
import '../models/itinerary_mapper.dart';

class ItineraryRepositoryImpl implements ItineraryRepository {
  final ItineraryLocalDataSource localDataSource;

  ItineraryRepositoryImpl({required this.localDataSource});

  @override
  Stream<List<ItineraryItemEntity>> watchTripItinerary(String tripId) {
    return localDataSource.watchTripItinerary(tripId).map(
          (models) => models.map((m) => ItineraryMapper.toEntity(m)).toList(),
        );
  }

  @override
  Future<Either<Failure, void>> addItineraryItem(ItineraryItemEntity item) async {
    try {
      final model = ItineraryMapper.toModel(item);
      model.isSynced = false;
      await localDataSource.addItineraryItem(model);
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateItineraryItem(ItineraryItemEntity item) async {
    try {
      final model = ItineraryMapper.toModel(item);
      model.isSynced = false;
      await localDataSource.updateItineraryItem(model);
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteItineraryItem(String id) async {
    try {
      await localDataSource.deleteItineraryItem(id);
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return const Left(StorageFailure());
    }
  }
}
