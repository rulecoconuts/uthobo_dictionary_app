// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_of_speech_creation_context.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$partOfSpeechCreationContextHash() =>
    r'0ca6b3de0d2202f77c93adb52d01d96d8b35e42d';

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

abstract class _$PartOfSpeechCreationContext
    extends BuildlessAutoDisposeNotifier<PartOfSpeechDomainObject?> {
  late final String signature;

  PartOfSpeechDomainObject? build(
    String signature,
  );
}

/// A provider that uniquely identifies and maintains a context for creation
/// of part of speech across pages
///
/// Copied from [PartOfSpeechCreationContext].
@ProviderFor(PartOfSpeechCreationContext)
const partOfSpeechCreationContextProvider = PartOfSpeechCreationContextFamily();

/// A provider that uniquely identifies and maintains a context for creation
/// of part of speech across pages
///
/// Copied from [PartOfSpeechCreationContext].
class PartOfSpeechCreationContextFamily
    extends Family<PartOfSpeechDomainObject?> {
  /// A provider that uniquely identifies and maintains a context for creation
  /// of part of speech across pages
  ///
  /// Copied from [PartOfSpeechCreationContext].
  const PartOfSpeechCreationContextFamily();

  /// A provider that uniquely identifies and maintains a context for creation
  /// of part of speech across pages
  ///
  /// Copied from [PartOfSpeechCreationContext].
  PartOfSpeechCreationContextProvider call(
    String signature,
  ) {
    return PartOfSpeechCreationContextProvider(
      signature,
    );
  }

  @override
  PartOfSpeechCreationContextProvider getProviderOverride(
    covariant PartOfSpeechCreationContextProvider provider,
  ) {
    return call(
      provider.signature,
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
  String? get name => r'partOfSpeechCreationContextProvider';
}

/// A provider that uniquely identifies and maintains a context for creation
/// of part of speech across pages
///
/// Copied from [PartOfSpeechCreationContext].
class PartOfSpeechCreationContextProvider
    extends AutoDisposeNotifierProviderImpl<PartOfSpeechCreationContext,
        PartOfSpeechDomainObject?> {
  /// A provider that uniquely identifies and maintains a context for creation
  /// of part of speech across pages
  ///
  /// Copied from [PartOfSpeechCreationContext].
  PartOfSpeechCreationContextProvider(
    String signature,
  ) : this._internal(
          () => PartOfSpeechCreationContext()..signature = signature,
          from: partOfSpeechCreationContextProvider,
          name: r'partOfSpeechCreationContextProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$partOfSpeechCreationContextHash,
          dependencies: PartOfSpeechCreationContextFamily._dependencies,
          allTransitiveDependencies:
              PartOfSpeechCreationContextFamily._allTransitiveDependencies,
          signature: signature,
        );

  PartOfSpeechCreationContextProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.signature,
  }) : super.internal();

  final String signature;

  @override
  PartOfSpeechDomainObject? runNotifierBuild(
    covariant PartOfSpeechCreationContext notifier,
  ) {
    return notifier.build(
      signature,
    );
  }

  @override
  Override overrideWith(PartOfSpeechCreationContext Function() create) {
    return ProviderOverride(
      origin: this,
      override: PartOfSpeechCreationContextProvider._internal(
        () => create()..signature = signature,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        signature: signature,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<PartOfSpeechCreationContext,
      PartOfSpeechDomainObject?> createElement() {
    return _PartOfSpeechCreationContextProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PartOfSpeechCreationContextProvider &&
        other.signature == signature;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, signature.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PartOfSpeechCreationContextRef
    on AutoDisposeNotifierProviderRef<PartOfSpeechDomainObject?> {
  /// The parameter `signature` of this provider.
  String get signature;
}

class _PartOfSpeechCreationContextProviderElement
    extends AutoDisposeNotifierProviderElement<PartOfSpeechCreationContext,
        PartOfSpeechDomainObject?> with PartOfSpeechCreationContextRef {
  _PartOfSpeechCreationContextProviderElement(super.provider);

  @override
  String get signature =>
      (origin as PartOfSpeechCreationContextProvider).signature;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
