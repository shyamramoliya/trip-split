// lib/navigation/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/route_constants.dart';

import '../features/trips/presentation/screens/splash_screen.dart';
import '../features/trips/presentation/screens/home_screen.dart';
import '../features/trips/presentation/screens/trip_creation_screen.dart';
import '../features/trips/presentation/screens/trip_detail_screen.dart';
import '../features/expenses/presentation/screens/expense_entry_screen.dart';
import '../features/search/presentation/screens/search_filter_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteConstants.splash,
  routes: [
    GoRoute(
      path: RouteConstants.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteConstants.home,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: RouteConstants.tripCreate,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const TripCreationScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    ),
    GoRoute(
      path: RouteConstants.tripDetail,
      builder: (context, state) {
        final tripId = state.pathParameters['tripId']!;
        return TripDetailScreen(tripId: tripId);
      },
      routes: [
        GoRoute(
          path: RouteConstants.expenseAdd,
          builder: (context, state) {
            final tripId = state.pathParameters['tripId']!;
            return ExpenseEntryScreen(tripId: tripId);
          },
        ),
        GoRoute(
          path: RouteConstants.expenseEdit,
          builder: (context, state) {
            final tripId = state.pathParameters['tripId']!;
            final expenseId = state.pathParameters['expenseId']!;
            return ExpenseEntryScreen(tripId: tripId, expenseId: expenseId);
          },
        ),
      ],
    ),
    GoRoute(
      path: RouteConstants.search,
      builder: (context, state) => const SearchFilterScreen(),
    ),
    GoRoute(
      path: RouteConstants.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
