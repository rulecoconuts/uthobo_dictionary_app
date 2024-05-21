// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pronunciation_list_future_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pronunciationListFutureHash() =>
    r'eab2df1c1c28341b48ccc8a5b3474e217081160b';

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

abstract class _$PronunciationListFuture
    extends BuildlessAutoDisposeAsyncNotifier<List<PronunciationDomainObject>> {
  late final WordPartDomainObject wordPart;

  FutureOr<List<PronunciationDomainObject>> build(
    WordPartDomainObject wordPart,
  );
}

/// See also [PronunciationListFuture].
@ProviderFor(PronunciationListFuture)
const pronunciationListFutureProvider = PronunciationListFutureFamily();

/// See also [PronunciationListFuture].
class PronunciationListFutureFamily
    extends Family<AsyncValue<List<PronunciationDomainObject>>> {
  /// See also [PronunciationListFuture].
  const PronunciationListFutureFamily();

  /// See also [PronunciationListFuture].
  PronunciationListFutureProvider call(
    WordPartDomainObject wordPart,
  ) {
    return PronunciationListFutureProvider(
      wordPart,
    );
  }

  @override
  PronunciationListFutureProvider getProviderOverride(
    covariant PronunciationListFutureProvider provider,
  ) {
    return call(
      provider.wordPart,
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
  String? get name => r'pronunciationListFutureProvider';
}

/// See also [PronunciationListFuture].
class PronunciationListFutureProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PronunciationListFuture,
        List<PronunciationDomainObject>> {
  /// See also [PronunciationListFuture].
  PronunciationListFutureProvider(
    WordPartDomainObject wordPart,
  ) : this._internal(
          () => PronunciationListFuture()..wordPart = wordPart,
          from: pronunciationListFutureProvider,
          name: r'pronunciationListFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pronunciationListFutureHash,
          dependencies: PronunciationListFutureFamily._dependencies,
          allTransitiveDependencies:
              PronunciationListFutureFamily._allTransitiveDependencies,
          wordPart: wordPart,
        );

  PronunciationListFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.wordPart,
  }) : super.internal();

  final WordPartDomainObject wordPart;

  @override
  FutureOr<List<PronunciationDomainObject>> runNotifierBuild(
    covariant PronunciationListFuture notifier,
  ) {
    return notifier.build(
      wordPart,
    );
  }

  @override
  Override overrideWith(PronunciationListFuture Function() create) {
    return ProviderOverride(
      origin: this,
      override: PronunciationListFutureProvider._internal(
        () => create()..wordPart = wordPart,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        wordPart: wordPart,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PronunciationListFuture,
      List<PronunciationDomainObject>> createElement() {
    return _PronunciationListFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PronunciationListFutureProvider &&
        other.wordPart == wordPart;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wordPart.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PronunciationListFutureRef
    on AutoDisposeAsyncNotifierProviderRef<List<PronunciationDomainObject>> {
  /// The parameter `wordPart` of this provider.
  WordPartDomainObject get wordPart;
}

class _PronunciationListFutureProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PronunciationListFuture,
        List<PronunciationDomainObject>> with PronunciationListFutureRef {
  _PronunciationListFutureProviderElement(super.provider);

  @override
  WordPartDomainObject get wordPart =>
      (origin as PronunciationListFutureProvider).wordPart;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
