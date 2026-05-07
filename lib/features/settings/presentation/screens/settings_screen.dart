// lib/features/settings/presentation/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../offline/sync_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(RouteConstants.home),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Section
          Row(
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: Colors.blue,
                child: Text('ME', style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Profile', style: Theme.of(context).textTheme.titleLarge),
                  const Text('Local user'),
                ],
              )
            ],
          ),
          const SizedBox(height: 32),
          
          Text('Preferences', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.payments_outlined),
            title: const Text('Default Currency'),
            trailing: const Text('INR >', style: TextStyle(color: Colors.grey)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text('Theme'),
            trailing: const Text('System >', style: TextStyle(color: Colors.grey)),
            onTap: () {},
          ),
          
          const SizedBox(height: 24),
          Text('Sync & Data', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.sync),
            title: const Text('Manual Sync'),
            subtitle: Text('${ref.watch(pendingSyncCountProvider)} items pending'),
            trailing: AppButton(
              label: 'Sync Now',
              variant: AppButtonVariant.outlined,
              onPressed: () {
                ref.read(syncServiceProvider).processQueue();
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.download_outlined),
            title: const Text('Export Data'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text('Clear All Data', style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
          
          const SizedBox(height: 24),
          Text('About', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 8),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Version'),
            trailing: Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}
