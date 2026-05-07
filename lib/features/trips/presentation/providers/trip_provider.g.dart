// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allTripsHash() => r'8881d1923fd8f11c7a0a7a349ebb02c5ae634768';

/// See also [allTrips].
@ProviderFor(allTrips)
final allTripsProvider = AutoDisposeStreamProvider<List<TripEntity>>.internal(
  allTrips,
  name: r'allTripsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allTripsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllTripsRef = AutoDisposeStreamProviderRef<List<TripEntity>>;
String _$tripByIdHash() => r'e1f006da4df93eaaa2fb85eb43a86925958f4a43';

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

/// See also [tripById].
@ProviderFor(tripById)
const tripByIdProvider = TripByIdFamily();

/// See also [tripById].
class TripByIdFamily extends Family<TripEntity?> {
  /// See also [tripById].
  const TripByIdFamily();

  /// See also [tripById].
  TripByIdProvider call(
    String tripId,
  ) {
    return TripByIdProvider(
      tripId,
    );
  }

  @override
  TripByIdProvider getProviderOverride(
    covariant TripByIdProvider provider,
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
  String? get name => r'tripByIdProvider';
}

/// See also [tripById].
class TripByIdProvider extends AutoDisposeProvider<TripEntity?> {
  /// See also [tripById].
  TripByIdProvider(
    String tripId,
  ) : this._internal(
          (ref) => tripById(
            ref as TripByIdRef,
            tripId,
          ),
          from: tripByIdProvider,
          name: r'tripByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tripByIdHash,
          dependencies: TripByIdFamily._dependencies,
          allTransitiveDependencies: TripByIdFamily._allTransitiveDependencies,
          tripId: tripId,
        );

  TripByIdProvider._internal(
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
    TripEntity? Function(TripByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TripByIdProvider._internal(
        (ref) => create(ref as TripByIdRef),
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
  AutoDisposeProviderElement<TripEntity?> createElement() {
    return _TripByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TripByIdProvider && other.tripId == tripId;
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
mixin TripByIdRef on AutoDisposeProviderRef<TripEntity?> {
  /// The parameter `tripId` of this provider.
  String get tripId;
}

class _TripByIdProviderElement extends AutoDisposeProviderElement<TripEntity?>
    with TripByIdRef {
  _TripByIdProviderElement(super.provider);

  @override
  String get tripId => (origin as TripByIdProvider).tripId;
}

String _$tripNotifierHash() => r'9ae533493f264ac4f2964d46c18f017c43f89219';

/// See also [TripNotifier].
@ProviderFor(TripNotifier)
final tripNotifierProvider =
    AutoDisposeNotifierProvider<TripNotifier, void>.internal(
  TripNotifier.new,
  name: r'tripNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tripNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TripNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
