// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:firebase_core/firebase_core.dart'; // Optional Sync Layer
import 'app.dart';
import 'core/constants/hive_constants.dart';

import 'features/trips/data/models/trip_model.dart';
import 'features/trips/data/models/participant_model.dart';
import 'features/itinerary/data/models/itinerary_item_model.dart';
import 'features/expenses/data/models/expense_model.dart';
import 'offline/sync_queue_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase safely
  /* 
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }
  */

  // Initialize Local Storage
  await Hive.initFlutter();

  // Register Adapters
  Hive.registerAdapter(TripModelAdapter());
  Hive.registerAdapter(ParticipantModelAdapter());
  Hive.registerAdapter(ItineraryItemModelAdapter());
  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(SyncQueueItemAdapter());

  // Open Boxes
  await Future.wait([
    Hive.openBox<TripModel>(HiveConstants.tripsBox),
    Hive.openBox<ParticipantModel>(HiveConstants.participantsBox),
    Hive.openBox<ItineraryItemModel>(HiveConstants.itineraryBox),
    Hive.openBox<ExpenseModel>(HiveConstants.expensesBox),
    Hive.openBox<SyncQueueItem>(HiveConstants.syncQueueBox),
  ]);

  runApp(
    const ProviderScope(
      child: TripSplitApp(),
    ),
  );
}
