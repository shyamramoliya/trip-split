// lib/core/widgets/sync_status_indicator.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../offline/sync_service.dart';

class SyncStatusIndicator extends ConsumerWidget {
  const SyncStatusIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(syncStatusProvider);
    final count = ref.watch(pendingSyncCountProvider);

    IconData icon;
    Color color;

    switch (status) {
      case SyncStatus.synced:
        icon = Icons.cloud_done;
        color = Colors.green;
        break;
      case SyncStatus.syncing:
        icon = Icons.cloud_sync;
        color = Theme.of(context).colorScheme.primary;
        break;
      case SyncStatus.pendingSync:
        icon = Icons.cloud_upload;
        color = Colors.orange;
        break;
      case SyncStatus.error:
        icon = Icons.cloud_off;
        color = Colors.red;
        break;
    }

    Widget indicator = Icon(icon, color: color, size: 24);

    if (status == SyncStatus.syncing) {
      indicator = indicator.animate(onPlay: (c) => c.repeat())
          .rotate(duration: const Duration(seconds: 2));
    }

    return IconButton(
      icon: Stack(
        alignment: Alignment.topRight,
        children: [
          indicator,
          if (count > 0 && status != SyncStatus.syncing)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                child: Text(
                  '$count',
                  style: const TextStyle(fontSize: 8, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      onPressed: () {
        // Show sync details bottom sheet
        showModalBottomSheet(
          context: context,
          builder: (context) => _SyncDetailsSheet(status: status, count: count),
        );
      },
    );
  }
}

class _SyncDetailsSheet extends StatelessWidget {
  final SyncStatus status;
  final int count;

  const _SyncDetailsSheet({required this.status, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Sync Status', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text('Current state: ${status.name}'),
            subtitle: Text('$count items pending sync'),
          ),
        ],
      ),
    );
  }
}
