// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itinerary_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tripItineraryHash() => r'0a167952bd203d782ef361da41454af177c02d01';

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

/// See also [tripItinerary].
@ProviderFor(tripItinerary)
const tripItineraryProvider = TripItineraryFamily();

/// See also [tripItinerary].
class TripItineraryFamily
    extends Family<AsyncValue<List<ItineraryItemEntity>>> {
  /// See also [tripItinerary].
  const TripItineraryFamily();

  /// See also [tripItinerary].
  TripItineraryProvider call(
    String tripId,
  ) {
    return TripItineraryProvider(
      tripId,
    );
  }

  @override
  TripItineraryProvider getProviderOverride(
    covariant TripItineraryProvider provider,
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
  String? get name => r'tripItineraryProvider';
}

/// See also [tripItinerary].
class TripItineraryProvider
    extends AutoDisposeStreamProvider<List<ItineraryItemEntity>> {
  /// See also [tripItinerary].
  TripItineraryProvider(
    String tripId,
  ) : this._internal(
          (ref) => tripItinerary(
            ref as TripItineraryRef,
            tripId,
          ),
          from: tripItineraryProvider,
          name: r'tripItineraryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tripItineraryHash,
          dependencies: TripItineraryFamily._dependencies,
          allTransitiveDependencies:
              TripItineraryFamily._allTransitiveDependencies,
          tripId: tripId,
        );

  TripItineraryProvider._internal(
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
    Stream<List<ItineraryItemEntity>> Function(TripItineraryRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TripItineraryProvider._internal(
        (ref) => create(ref as TripItineraryRef),
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
  AutoDisposeStreamProviderElement<List<ItineraryItemEntity>> createElement() {
    return _TripItineraryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TripItineraryProvider && other.tripId == tripId;
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
mixin TripItineraryRef
    on AutoDisposeStreamProviderRef<List<ItineraryItemEntity>> {
  /// The parameter `tripId` of this provider.
  String get tripId;
}

class _TripItineraryProviderElement
    extends AutoDisposeStreamProviderElement<List<ItineraryItemEntity>>
    with TripItineraryRef {
  _TripItineraryProviderElement(super.provider);

  @override
  String get tripId => (origin as TripItineraryProvider).tripId;
}

String _$itineraryNotifierHash() => r'98f54a4b362382de1c0fa916b7362b54111c8b80';

/// See also [ItineraryNotifier].
@ProviderFor(ItineraryNotifier)
final itineraryNotifierProvider =
    AutoDisposeNotifierProvider<ItineraryNotifier, void>.internal(
  ItineraryNotifier.new,
  name: r'itineraryNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$itineraryNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ItineraryNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
