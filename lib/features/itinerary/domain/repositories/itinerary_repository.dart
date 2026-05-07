// lib/features/itinerary/domain/repositories/itinerary_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/itinerary_item_entity.dart';

abstract class ItineraryRepository {
  Stream<List<ItineraryItemEntity>> watchTripItinerary(String tripId);
  Future<Either<Failure, void>> addItineraryItem(ItineraryItemEntity item);
  Future<Either<Failure, void>> updateItineraryItem(ItineraryItemEntity item);
  Future<Either<Failure, void>> deleteItineraryItem(String id);
}
