// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_list_future_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$translationListFutureHash() =>
    r'25fa0ac64564155994ba5af5f5f0bc341df1b354';

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

abstract class _$TranslationListFuture
    extends BuildlessAutoDisposeAsyncNotifier<List<FullTranslation>> {
  late final WordPartDomainObject wordPart;

  FutureOr<List<FullTranslation>> build(
    WordPartDomainObject wordPart,
  );
}

/// See also [TranslationListFuture].
@ProviderFor(TranslationListFuture)
const translationListFutureProvider = TranslationListFutureFamily();

/// See also [TranslationListFuture].
class TranslationListFutureFamily
    extends Family<AsyncValue<List<FullTranslation>>> {
  /// See also [TranslationListFuture].
  const TranslationListFutureFamily();

  /// See also [TranslationListFuture].
  TranslationListFutureProvider call(
    WordPartDomainObject wordPart,
  ) {
    return TranslationListFutureProvider(
      wordPart,
    );
  }

  @override
  TranslationListFutureProvider getProviderOverride(
    covariant TranslationListFutureProvider provider,
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
  String? get name => r'translationListFutureProvider';
}

/// See also [TranslationListFuture].
class TranslationListFutureProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TranslationListFuture,
        List<FullTranslation>> {
  /// See also [TranslationListFuture].
  TranslationListFutureProvider(
    WordPartDomainObject wordPart,
  ) : this._internal(
          () => TranslationListFuture()..wordPart = wordPart,
          from: translationListFutureProvider,
          name: r'translationListFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$translationListFutureHash,
          dependencies: TranslationListFutureFamily._dependencies,
          allTransitiveDependencies:
              TranslationListFutureFamily._allTransitiveDependencies,
          wordPart: wordPart,
        );

  TranslationListFutureProvider._internal(
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
  FutureOr<List<FullTranslation>> runNotifierBuild(
    covariant TranslationListFuture notifier,
  ) {
    return notifier.build(
      wordPart,
    );
  }

  @override
  Override overrideWith(TranslationListFuture Function() create) {
    return ProviderOverride(
      origin: this,
      override: TranslationListFutureProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<TranslationListFuture,
      List<FullTranslation>> createElement() {
    return _TranslationListFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TranslationListFutureProvider && other.wordPart == wordPart;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wordPart.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TranslationListFutureRef
    on AutoDisposeAsyncNotifierProviderRef<List<FullTranslation>> {
  /// The parameter `wordPart` of this provider.
  WordPartDomainObject get wordPart;
}

class _TranslationListFutureProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TranslationListFuture,
        List<FullTranslation>> with TranslationListFutureRef {
  _TranslationListFutureProviderElement(super.provider);

  @override
  WordPartDomainObject get wordPart =>
      (origin as TranslationListFutureProvider).wordPart;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
