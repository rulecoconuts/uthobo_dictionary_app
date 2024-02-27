// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_of_speech_control.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$partOfSpeechControlHash() =>
    r'29abaf77155b646a627c47cbb3e5c31721aefbce';

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

abstract class _$PartOfSpeechControl extends BuildlessAutoDisposeAsyncNotifier<
    ApiPage<PartOfSpeechDomainObject>> {
  late final String namePattern;
  late final ApiPageDetails pageDetails;

  FutureOr<ApiPage<PartOfSpeechDomainObject>> build(
    String namePattern, {
    ApiPageDetails pageDetails = const ApiPageDetails(),
  });
}

/// See also [PartOfSpeechControl].
@ProviderFor(PartOfSpeechControl)
const partOfSpeechControlProvider = PartOfSpeechControlFamily();

/// See also [PartOfSpeechControl].
class PartOfSpeechControlFamily
    extends Family<AsyncValue<ApiPage<PartOfSpeechDomainObject>>> {
  /// See also [PartOfSpeechControl].
  const PartOfSpeechControlFamily();

  /// See also [PartOfSpeechControl].
  PartOfSpeechControlProvider call(
    String namePattern, {
    ApiPageDetails pageDetails = const ApiPageDetails(),
  }) {
    return PartOfSpeechControlProvider(
      namePattern,
      pageDetails: pageDetails,
    );
  }

  @override
  PartOfSpeechControlProvider getProviderOverride(
    covariant PartOfSpeechControlProvider provider,
  ) {
    return call(
      provider.namePattern,
      pageDetails: provider.pageDetails,
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
  String? get name => r'partOfSpeechControlProvider';
}

/// See also [PartOfSpeechControl].
class PartOfSpeechControlProvider extends AutoDisposeAsyncNotifierProviderImpl<
    PartOfSpeechControl, ApiPage<PartOfSpeechDomainObject>> {
  /// See also [PartOfSpeechControl].
  PartOfSpeechControlProvider(
    String namePattern, {
    ApiPageDetails pageDetails = const ApiPageDetails(),
  }) : this._internal(
          () => PartOfSpeechControl()
            ..namePattern = namePattern
            ..pageDetails = pageDetails,
          from: partOfSpeechControlProvider,
          name: r'partOfSpeechControlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$partOfSpeechControlHash,
          dependencies: PartOfSpeechControlFamily._dependencies,
          allTransitiveDependencies:
              PartOfSpeechControlFamily._allTransitiveDependencies,
          namePattern: namePattern,
          pageDetails: pageDetails,
        );

  PartOfSpeechControlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.namePattern,
    required this.pageDetails,
  }) : super.internal();

  final String namePattern;
  final ApiPageDetails pageDetails;

  @override
  FutureOr<ApiPage<PartOfSpeechDomainObject>> runNotifierBuild(
    covariant PartOfSpeechControl notifier,
  ) {
    return notifier.build(
      namePattern,
      pageDetails: pageDetails,
    );
  }

  @override
  Override overrideWith(PartOfSpeechControl Function() create) {
    return ProviderOverride(
      origin: this,
      override: PartOfSpeechControlProvider._internal(
        () => create()
          ..namePattern = namePattern
          ..pageDetails = pageDetails,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        namePattern: namePattern,
        pageDetails: pageDetails,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PartOfSpeechControl,
      ApiPage<PartOfSpeechDomainObject>> createElement() {
    return _PartOfSpeechControlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PartOfSpeechControlProvider &&
        other.namePattern == namePattern &&
        other.pageDetails == pageDetails;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, namePattern.hashCode);
    hash = _SystemHash.combine(hash, pageDetails.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PartOfSpeechControlRef
    on AutoDisposeAsyncNotifierProviderRef<ApiPage<PartOfSpeechDomainObject>> {
  /// The parameter `namePattern` of this provider.
  String get namePattern;

  /// The parameter `pageDetails` of this provider.
  ApiPageDetails get pageDetails;
}

class _PartOfSpeechControlProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PartOfSpeechControl,
        ApiPage<PartOfSpeechDomainObject>> with PartOfSpeechControlRef {
  _PartOfSpeechControlProviderElement(super.provider);

  @override
  String get namePattern => (origin as PartOfSpeechControlProvider).namePattern;
  @override
  ApiPageDetails get pageDetails =>
      (origin as PartOfSpeechControlProvider).pageDetails;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
