// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tripExpensesHash() => r'ed180ba7dcf4d7dfefdab7fc857fecce3bf15904';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [tripExpenses].
@ProviderFor(tripExpenses)
const tripExpensesProvider = TripExpensesFamily();

/// See also [tripExpenses].
class TripExpensesFamily extends Family<AsyncValue<List<ExpenseEntity>>> {
  /// See also [tripExpenses].
  const TripExpensesFamily();

  /// See also [tripExpenses].
  TripExpensesProvider call(
    String tripId,
  ) {
    return TripExpensesProvider(
      tripId,
    );
  }

  @override
  TripExpensesProvider getProviderOverride(
    covariant TripExpensesProvider provider,
  ) {
    return call(
      provider.tripId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tripExpensesProvider';
}

/// See also [tripExpenses].
class TripExpensesProvider
    extends AutoDisposeStreamProvider<List<ExpenseEntity>> {
  /// See also [tripExpenses].
  TripExpensesProvider(
    String tripId,
  ) : this._internal(
          (ref) => tripExpenses(
            ref as TripExpensesRef,
            tripId,
          ),
          from: tripExpensesProvider,
          name: r'tripExpensesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tripExpensesHash,
          dependencies: TripExpensesFamily._dependencies,
          allTransitiveDependencies:
              TripExpensesFamily._allTransitiveDependencies,
          tripId: tripId,
        );

  TripExpensesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tripId,
  }) : super.internal();

  final String tripId;

  @override
  Override overrideWith(
    Stream<List<ExpenseEntity>> Function(TripExpensesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TripExpensesProvider._internal(
        (ref) => create(ref as TripExpensesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tripId: tripId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<ExpenseEntity>> createElement() {
    return _TripExpensesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TripExpensesProvider && other.tripId == tripId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TripExpensesRef on AutoDisposeStreamProviderRef<List<ExpenseEntity>> {
  /// The parameter `tripId` of this provider.
  String get tripId;
}

class _TripExpensesProviderElement
    extends AutoDisposeStreamProviderElement<List<ExpenseEntity>>
    with TripExpensesRef {
  _TripExpensesProviderElement(super.provider);

  @override
  String get tripId => (origin as TripExpensesProvider).tripId;
}

String _$participantBalancesHash() =>
    r'49dbb92e6df1011a4445e066c7aaa765d2403b8e';

/// See also [participantBalances].
@ProviderFor(participantBalances)
const participantBalancesProvider = ParticipantBalancesFamily();

/// See also [participantBalances].
class ParticipantBalancesFamily extends Family<Map<String, double>> {
  /// See also [participantBalances].
  const ParticipantBalancesFamily();

  /// See also [participantBalances].
  ParticipantBalancesProvider call(
    String tripId,
  ) {
    return ParticipantBalancesProvider(
      tripId,
    );
  }

  @override
  ParticipantBalancesProvider getProviderOverride(
    covariant ParticipantBalancesProvider provider,
  ) {
    return call(
      provider.tripId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'participantBalancesProvider';
}

/// See also [participantBalances].
class ParticipantBalancesProvider
    extends AutoDisposeProvider<Map<String, double>> {
  /// See also [participantBalances].
  ParticipantBalancesProvider(
    String tripId,
  ) : this._internal(
          (ref) => participantBalances(
            ref as ParticipantBalancesRef,
            tripId,
          ),
          from: participantBalancesProvider,
          name: r'participantBalancesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$participantBalancesHash,
          dependencies: ParticipantBalancesFamily._dependencies,
          allTransitiveDependencies:
              ParticipantBalancesFamily._allTransitiveDependencies,
          tripId: tripId,
        );

  ParticipantBalancesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tripId,
  }) : super.internal();

  final String tripId;

  @override
  Override overrideWith(
    Map<String, double> Function(ParticipantBalancesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ParticipantBalancesProvider._internal(
        (ref) => create(ref as ParticipantBalancesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tripId: tripId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Map<String, double>> createElement() {
    return _ParticipantBalancesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ParticipantBalancesProvider && other.tripId == tripId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ParticipantBalancesRef on AutoDisposeProviderRef<Map<String, double>> {
  /// The parameter `tripId` of this provider.
  String get tripId;
}

class _ParticipantBalancesProviderElement
    extends AutoDisposeProviderElement<Map<String, double>>
    with ParticipantBalancesRef {
  _ParticipantBalancesProviderElement(super.provider);

  @override
  String get tripId => (origin as ParticipantBalancesProvider).tripId;
}

String _$simplifiedSettlementsHash() =>
    r'cbd3f10fef8ea7d4f33730745a3e129afad0ff34';

/// See also [simplifiedSettlements].
@ProviderFor(simplifiedSettlements)
const simplifiedSettlementsProvider = SimplifiedSettlementsFamily();

/// See also [simplifiedSettlements].
class SimplifiedSettlementsFamily extends Family<List<Settlement>> {
  /// See also [simplifiedSettlements].
  const SimplifiedSettlementsFamily();

  /// See also [simplifiedSettlements].
  SimplifiedSettlementsProvider call(
    String tripId,
  ) {
    return SimplifiedSettlementsProvider(
      tripId,
    );
  }

  @override
  SimplifiedSettlementsProvider getProviderOverride(
    covariant SimplifiedSettlementsProvider provider,
  ) {
    return call(
      provider.tripId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'simplifiedSettlementsProvider';
}

/// See also [simplifiedSettlements].
class SimplifiedSettlementsProvider
    extends AutoDisposeProvider<List<Settlement>> {
  /// See also [simplifiedSettlements].
  SimplifiedSettlementsProvider(
    String tripId,
  ) : this._internal(
          (ref) => simplifiedSettlements(
            ref as SimplifiedSettlementsRef,
            tripId,
          ),
          from: simplifiedSettlementsProvider,
          name: r'simplifiedSettlementsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$simplifiedSettlementsHash,
          dependencies: SimplifiedSettlementsFamily._dependencies,
          allTransitiveDependencies:
              SimplifiedSettlementsFamily._allTransitiveDependencies,
          tripId: tripId,
        );

  SimplifiedSettlementsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tripId,
  }) : super.internal();

  final String tripId;

  @override
  Override overrideWith(
    List<Settlement> Function(SimplifiedSettlementsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SimplifiedSettlementsProvider._internal(
        (ref) => create(ref as SimplifiedSettlementsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tripId: tripId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<Settlement>> createElement() {
    return _SimplifiedSettlementsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SimplifiedSettlementsProvider && other.tripId == tripId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SimplifiedSettlementsRef on AutoDisposeProviderRef<List<Settlement>> {
  /// The parameter `tripId` of this provider.
  String get tripId;
}

class _SimplifiedSettlementsProviderElement
    extends AutoDisposeProviderElement<List<Settlement>>
    with SimplifiedSettlementsRef {
  _SimplifiedSettlementsProviderElement(super.provider);

  @override
  String get tripId => (origin as SimplifiedSettlementsProvider).tripId;
}

String _$expensesByCategoryHash() =>
    r'f5db57465983d6a1b510f19f8bd904482029716e';

/// See also [expensesByCategory].
@ProviderFor(expensesByCategory)
const expensesByCategoryProvider = ExpensesByCategoryFamily();

/// See also [expensesByCategory].
class ExpensesByCategoryFamily extends Family<Map<String, double>> {
  /// See also [expensesByCategory].
  const ExpensesByCategoryFamily();

  /// See also [expensesByCategory].
  ExpensesByCategoryProvider call(
    String tripId,
  ) {
    return ExpensesByCategoryProvider(
      tripId,
    );
  }

  @override
  ExpensesByCategoryProvider getProviderOverride(
    covariant ExpensesByCategoryProvider provider,
  ) {
    return call(
      provider.tripId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'expensesByCategoryProvider';
}

/// See also [expensesByCategory].
class ExpensesByCategoryProvider
    extends AutoDisposeProvider<Map<String, double>> {
  /// See also [expensesByCategory].
  ExpensesByCategoryProvider(
    String tripId,
  ) : this._internal(
          (ref) => expensesByCategory(
            ref as ExpensesByCategoryRef,
            tripId,
          ),
          from: expensesByCategoryProvider,
          name: r'expensesByCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$expensesByCategoryHash,
          dependencies: ExpensesByCategoryFamily._dependencies,
          allTransitiveDependencies:
              ExpensesByCategoryFamily._allTransitiveDependencies,
          tripId: tripId,
        );

  ExpensesByCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tripId,
  }) : super.internal();

  final String tripId;

  @override
  Override overrideWith(
    Map<String, double> Function(ExpensesByCategoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExpensesByCategoryProvider._internal(
        (ref) => create(ref as ExpensesByCategoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tripId: tripId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Map<String, double>> createElement() {
    return _ExpensesByCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpensesByCategoryProvider && other.tripId == tripId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ExpensesByCategoryRef on AutoDisposeProviderRef<Map<String, double>> {
  /// The parameter `tripId` of this provider.
  String get tripId;
}

class _ExpensesByCategoryProviderElement
    extends AutoDisposeProviderElement<Map<String, double>>
    with ExpensesByCategoryRef {
  _ExpensesByCategoryProviderElement(super.provider);

  @override
  String get tripId => (origin as ExpensesByCategoryProvider).tripId;
}

String _$totalTripExpenseHash() => r'f6082d7e563535cf0a5ed15968e2ffae73aee9b8';

/// See also [totalTripExpense].
@ProviderFor(totalTripExpense)
const totalTripExpenseProvider = TotalTripExpenseFamily();

/// See also [totalTripExpense].
class TotalTripExpenseFamily extends Family<double> {
  /// See also [totalTripExpense].
  const TotalTripExpenseFamily();

  /// See also [totalTripExpense].
  TotalTripExpenseProvider call(
    String tripId,
  ) {
    return TotalTripExpenseProvider(
      tripId,
    );
  }

  @override
  TotalTripExpenseProvider getProviderOverride(
    covariant TotalTripExpenseProvider provider,
  ) {
    return call(
      provider.tripId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'totalTripExpenseProvider';
}

/// See also [totalTripExpense].
class TotalTripExpenseProvider extends AutoDisposeProvider<double> {
  /// See also [totalTripExpense].
  TotalTripExpenseProvider(
    String tripId,
  ) : this._internal(
          (ref) => totalTripExpense(
            ref as TotalTripExpenseRef,
            tripId,
          ),
          from: totalTripExpenseProvider,
          name: r'totalTripExpenseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$totalTripExpenseHash,
          dependencies: TotalTripExpenseFamily._dependencies,
          allTransitiveDependencies:
              TotalTripExpenseFamily._allTransitiveDependencies,
          tripId: tripId,
        );

  TotalTripExpenseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tripId,
  }) : super.internal();

  final String tripId;

  @override
  Override overrideWith(
    double Function(TotalTripExpenseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TotalTripExpenseProvider._internal(
        (ref) => create(ref as TotalTripExpenseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tripId: tripId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<double> createElement() {
    return _TotalTripExpenseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TotalTripExpenseProvider && other.tripId == tripId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TotalTripExpenseRef on AutoDisposeProviderRef<double> {
  /// The parameter `tripId` of this provider.
  String get tripId;
}

class _TotalTripExpenseProviderElement
    extends AutoDisposeProviderElement<double> with TotalTripExpenseRef {
  _TotalTripExpenseProviderElement(super.provider);

  @override
  String get tripId => (origin as TotalTripExpenseProvider).tripId;
}

String _$expenseNotifierHash() => r'66b5eb9aba9f5b2d886572d487ca6a06a364c0f2';

/// See also [ExpenseNotifier].
@ProviderFor(ExpenseNotifier)
final expenseNotifierProvider =
    AutoDisposeNotifierProvider<ExpenseNotifier, void>.internal(
  ExpenseNotifier.new,
  name: r'expenseNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expenseNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpenseNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
