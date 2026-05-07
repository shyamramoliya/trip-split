// lib/features/search/presentation/providers/search_provider.dart
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../trips/domain/entities/trip_entity.dart';
import '../../../trips/presentation/providers/trip_provider.dart';
import '../../../expenses/domain/entities/expense_entity.dart';
import '../../../expenses/presentation/providers/expense_provider.dart';

part 'search_provider.g.dart';

@riverpod
class SearchFilterNotifier extends _$SearchFilterNotifier {
  @override
  SearchState build() {
    return SearchState();
  }

  void updateQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setFilterParticipant(String? participantId) {
    state = state.copyWith(filterByParticipant: participantId);
  }

  void setDateRange(DateTimeRange? range) {
    state = state.copyWith(dateRange: range);
  }

  void setSortBy(String? sortBy) {
    state = state.copyWith(sortBy: sortBy);
  }

  List<TripEntity> get filteredTrips {
    final tripsStream = ref.read(allTripsProvider);
    final trips = tripsStream.value ?? [];
    
    return trips.where((trip) {
      final matchesQuery = trip.name.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          trip.destination.toLowerCase().contains(state.searchQuery.toLowerCase());
      
      final matchesParticipant = state.filterByParticipant == null || 
          trip.participantIds.contains(state.filterByParticipant);
          
      final matchesDate = state.dateRange == null ||
          (trip.startDate.isAfter(state.dateRange!.start) && trip.endDate.isBefore(state.dateRange!.end));
          
      return matchesQuery && matchesParticipant && matchesDate;
    }).toList();
  }

  List<ExpenseEntity> getFilteredExpenses(String tripId) {
    final expensesStream = ref.read(tripExpensesProvider(tripId));
    final expenses = expensesStream.value ?? [];
    
    var filtered = expenses.where((expense) {
      final matchesQuery = expense.title.toLowerCase().contains(state.searchQuery.toLowerCase());
      
      final matchesParticipant = state.filterByParticipant == null || 
          expense.paidById == state.filterByParticipant ||
          expense.splitAmongIds.contains(state.filterByParticipant);
          
      final matchesDate = state.dateRange == null ||
          (expense.date.isAfter(state.dateRange!.start.subtract(const Duration(days: 1))) && 
           expense.date.isBefore(state.dateRange!.end.add(const Duration(days: 1))));
          
      return matchesQuery && matchesParticipant && matchesDate;
    }).toList();

    if (state.sortBy == 'date_desc') {
      filtered.sort((a, b) => b.date.compareTo(a.date));
    } else if (state.sortBy == 'date_asc') {
      filtered.sort((a, b) => a.date.compareTo(b.date));
    } else if (state.sortBy == 'amount_desc') {
      filtered.sort((a, b) => b.amount.compareTo(a.amount));
    } else if (state.sortBy == 'amount_asc') {
      filtered.sort((a, b) => a.amount.compareTo(b.amount));
    }

    return filtered;
  }
}

class SearchState {
  final String searchQuery;
  final String? filterByParticipant;
  final DateTimeRange? dateRange;
  final String? sortBy; // "date_desc", "date_asc", "amount_desc", "amount_asc"

  SearchState({
    this.searchQuery = '',
    this.filterByParticipant,
    this.dateRange,
    this.sortBy,
  });

  SearchState copyWith({
    String? searchQuery,
    String? filterByParticipant,
    DateTimeRange? dateRange,
    String? sortBy,
  }) {
    return SearchState(
      searchQuery: searchQuery ?? this.searchQuery,
      filterByParticipant: filterByParticipant != null ? (filterByParticipant.isEmpty ? null : filterByParticipant) : this.filterByParticipant,
      dateRange: dateRange ?? this.dateRange,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}
