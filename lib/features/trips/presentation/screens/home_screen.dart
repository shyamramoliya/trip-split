// lib/features/trips/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../../core/widgets/sync_status_indicator.dart';
import '../providers/trip_provider.dart';
import '../widgets/trip_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripsAsync = ref.watch(allTripsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TripSplit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push(RouteConstants.search),
          ),
          const SyncStatusIndicator(),
        ],
      ),
      body: tripsAsync.when(
        data: (trips) {
          if (trips.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.flight_takeoff,
              title: 'No trips yet',
              subtitle: 'Start your first trip to manage itinerary and expenses easily.',
              actionLabel: 'Create Trip',
              onAction: () => context.push(RouteConstants.tripCreate),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              // Usually we'd trigger a network sync here
              // ref.read(syncServiceProvider).processQueue();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: trips.length,
              itemBuilder: (context, index) {
                return TripCard(
                  trip: trips[index],
                  onTap: () {
                    context.push(RouteConstants.tripDetail.replaceAll(':tripId', trips[index].id));
                  },
                );
              },
            ),
          );
        },
        loading: () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 3,
          itemBuilder: (context, index) => const TripCardSkeleton(),
        ),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteConstants.tripCreate),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 1) context.push(RouteConstants.search);
          if (index == 2) context.push(RouteConstants.settings);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
