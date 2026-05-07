// lib/features/search/presentation/screens/search_filter_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../trips/presentation/widgets/trip_card.dart';
import '../providers/search_provider.dart';

class SearchFilterScreen extends ConsumerWidget {
  const SearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchFilterNotifierProvider);
    final notifier = ref.read(searchFilterNotifierProvider.notifier);
    final results = notifier.filteredTrips;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(RouteConstants.home),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppTextField(
              label: '',
              hint: 'Search trips by name or destination...',
              prefixIcon: const Icon(Icons.search),
              onTap: () {},
              // Use onChanged instead of controller for simplicity in this demo
            ),
          ),
          
          // Filter Chips Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: true,
                  onSelected: (_) {},
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('By Date'),
                  selected: false,
                  onSelected: (_) {},
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('By Participant'),
                  selected: false,
                  onSelected: (_) {},
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          Expanded(
            child: results.isEmpty
                ? const EmptyStateWidget(
                    icon: Icons.search_off,
                    title: 'No results found',
                    subtitle: 'Try adjusting your search or filters.',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      return TripCard(
                        trip: results[index],
                        onTap: () => context.push(RouteConstants.tripDetail.replaceAll(':tripId', results[index].id)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
