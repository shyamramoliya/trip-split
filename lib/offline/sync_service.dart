// lib/offline/sync_service.dart
import 'dart:async';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/hive_constants.dart';
import 'sync_queue_item.dart';
import 'connectivity_service.dart';

enum SyncStatus { synced, syncing, pendingSync, error }

class SyncService {
  final ConnectivityService _connectivityService;
  final Box<SyncQueueItem> _syncQueueBox;
  final Ref _ref;
  StreamSubscription? _connectivitySubscription;
  bool _isSyncing = false;

  SyncService(this._connectivityService, this._syncQueueBox, this._ref) {
    _startMonitoring();
  }

  void _startMonitoring() {
    _connectivitySubscription = _connectivityService.onConnectivityChanged.listen((results) {
      if (!results.contains(ConnectivityResult.none)) {
        processQueue();
      }
    });
  }

  Future<void> enqueueOperation(String operation, String entityType, String entityId, Map<String, dynamic> payload) async {
    final item = SyncQueueItem(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      operation: operation,
      entityType: entityType,
      entityId: entityId,
      payload: payload,
      timestamp: DateTime.now(),
    );
    await _syncQueueBox.put(item.id, item);
    _ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.pendingSync);
    
    // Try to sync immediately if connected
    if (await _connectivityService.isConnected()) {
      processQueue();
    }
  }

  Future<void> processQueue() async {
    if (_isSyncing || _syncQueueBox.isEmpty) return;
    
    _isSyncing = true;
    _ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.syncing);

    try {
      final items = _syncQueueBox.values.toList()
        ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

      for (final item in items) {
        // Here we would normally make the API call to Firebase or custom backend
        // e.g. await FirebaseFirestore.instance.collection(item.entityType).doc(item.entityId).set(item.payload);
        
        // Simulating network delay for realistic UI
        await Future.delayed(const Duration(milliseconds: 500));

        // On Success: remove from queue
        await _syncQueueBox.delete(item.id);
        
        // On Failure: increment retry count (not implemented in this mock)
      }

      if (_syncQueueBox.isEmpty) {
        _ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.synced);
      } else {
        _ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.pendingSync);
      }
    } catch (e) {
      _ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.error);
    } finally {
      _isSyncing = false;
    }
  }

  void dispose() {
    _connectivitySubscription?.cancel();
  }
}

// Sync Providers
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final syncServiceProvider = Provider<SyncService>((ref) {
  final connectivity = ref.watch(connectivityServiceProvider);
  final box = Hive.box<SyncQueueItem>(HiveConstants.syncQueueBox);
  return SyncService(connectivity, box, ref);
});

class SyncStatusNotifier extends StateNotifier<SyncStatus> {
  SyncStatusNotifier() : super(SyncStatus.synced);

  void setStatus(SyncStatus status) {
    state = status;
  }
}

final syncStatusProvider = StateNotifierProvider<SyncStatusNotifier, SyncStatus>((ref) {
  return SyncStatusNotifier();
});

final pendingSyncCountProvider = Provider<int>((ref) {
  // Hive listenable would be better here for reactivity
  final box = Hive.box<SyncQueueItem>(HiveConstants.syncQueueBox);
  return box.length;
});
