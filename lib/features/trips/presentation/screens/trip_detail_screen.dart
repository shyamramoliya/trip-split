// lib/features/trips/presentation/screens/trip_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../expenses/presentation/providers/expense_provider.dart';
import '../../../expenses/presentation/screens/expense_dashboard_screen.dart';
import '../../../expenses/presentation/screens/participant_balance_screen.dart';
import '../../../itinerary/presentation/screens/itinerary_screen.dart';
import '../providers/trip_provider.dart';
import '../widgets/participant_chip.dart';

class TripDetailScreen extends ConsumerStatefulWidget {
  final String tripId;

  const TripDetailScreen({super.key, required this.tripId});

  @override
  ConsumerState<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends ConsumerState<TripDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trip = ref.watch(tripByIdProvider(widget.tripId));
    if (trip == null) {
      return const Scaffold(body: Center(child: Text('Trip not found')));
    }

    final totalExpense = ref.watch(totalTripExpenseProvider(widget.tripId));

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              actions: [
                IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(trip.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        const Color(0xFF0D4A8A),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 48), // Space for back button
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.white70, size: 16),
                              const SizedBox(width: 4),
                              Text(trip.destination, style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormatter.formatRange(trip.startDate, trip.endDate),
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: trip.participants.take(4).map((p) => 
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: ParticipantAvatar(participant: p, size: 28),
                                  )
                                ).toList(),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text('Total Spent', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  Text(
                                    CurrencyFormatter.format(totalExpense, currency: trip.currency),
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  tabs: const [
                    Tab(text: 'Itinerary'),
                    Tab(text: 'Expenses'),
                    Tab(text: 'Balances'),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            ItineraryScreen(tripId: widget.tripId),
            ExpenseDashboardScreen(tripId: widget.tripId),
            ParticipantBalanceScreen(tripId: widget.tripId),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_tabController.index == 0) {
            // Add Itinerary
          } else if (_tabController.index == 1) {
            context.push('${RouteConstants.tripDetail.replaceAll(':tripId', trip.id)}/${RouteConstants.expenseAdd}');
          } else {
            // Settle up
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
