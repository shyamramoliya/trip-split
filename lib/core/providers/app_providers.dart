// lib/core/providers/app_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../features/trips/data/datasources/trip_local_datasource.dart';
import '../../features/trips/data/repositories/trip_repository_impl.dart';
import '../../features/trips/domain/repositories/trip_repository.dart';
import '../../features/trips/data/models/trip_model.dart';

import '../../features/itinerary/data/datasources/itinerary_local_datasource.dart';
import '../../features/itinerary/data/repositories/itinerary_repository_impl.dart';
import '../../features/itinerary/domain/repositories/itinerary_repository.dart';
import '../../features/itinerary/data/models/itinerary_item_model.dart';

import '../../features/expenses/data/datasources/expense_local_datasource.dart';
import '../../features/expenses/data/repositories/expense_repository_impl.dart';
import '../../features/expenses/domain/repositories/expense_repository.dart';
import '../../features/expenses/data/models/expense_model.dart';

import '../constants/hive_constants.dart';

final tripLocalDataSourceProvider = Provider<TripLocalDataSource>((ref) {
  return TripLocalDataSourceImpl(Hive.box<TripModel>(HiveConstants.tripsBox));
});

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  return TripRepositoryImpl(localDataSource: ref.watch(tripLocalDataSourceProvider));
});

final itineraryLocalDataSourceProvider = Provider<ItineraryLocalDataSource>((ref) {
  return ItineraryLocalDataSourceImpl(Hive.box<ItineraryItemModel>(HiveConstants.itineraryBox));
});

final itineraryRepositoryProvider = Provider<ItineraryRepository>((ref) {
  return ItineraryRepositoryImpl(localDataSource: ref.watch(itineraryLocalDataSourceProvider));
});

final expenseLocalDataSourceProvider = Provider<ExpenseLocalDataSource>((ref) {
  return ExpenseLocalDataSourceImpl(Hive.box<ExpenseModel>(HiveConstants.expensesBox));
});

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepositoryImpl(localDataSource: ref.watch(expenseLocalDataSourceProvider));
});
