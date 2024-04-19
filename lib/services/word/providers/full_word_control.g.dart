// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_word_control.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fullWordControlHash() => r'8442618408deec9c5aa779ae41e64d7f3f7e79a8';

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

abstract class _$FullWordControl
    extends BuildlessAutoDisposeAsyncNotifier<ApiPage<FullWordPart>> {
  late final String namePattern;
  late final LanguageDomainObject languageDomainObject;
  late final ApiPageDetails pageDetails;

  FutureOr<ApiPage<FullWordPart>> build(
    String namePattern,
    LanguageDomainObject languageDomainObject, {
    ApiPageDetails pageDetails = const ApiPageDetails(),
  });
}

/// See also [FullWordControl].
@ProviderFor(FullWordControl)
const fullWordControlProvider = FullWordControlFamily();

/// See also [FullWordControl].
class FullWordControlFamily extends Family<AsyncValue<ApiPage<FullWordPart>>> {
  /// See also [FullWordControl].
  const FullWordControlFamily();

  /// See also [FullWordControl].
  FullWordControlProvider call(
    String namePattern,
    LanguageDomainObject languageDomainObject, {
    ApiPageDetails pageDetails = const ApiPageDetails(),
  }) {
    return FullWordControlProvider(
      namePattern,
      languageDomainObject,
      pageDetails: pageDetails,
    );
  }

  @override
  FullWordControlProvider getProviderOverride(
    covariant FullWordControlProvider provider,
  ) {
    return call(
      provider.namePattern,
      provider.languageDomainObject,
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
  String? get name => r'fullWordControlProvider';
}

/// See also [FullWordControl].
class FullWordControlProvider extends AutoDisposeAsyncNotifierProviderImpl<
    FullWordControl, ApiPage<FullWordPart>> {
  /// See also [FullWordControl].
  FullWordControlProvider(
    String namePattern,
    LanguageDomainObject languageDomainObject, {
    ApiPageDetails pageDetails = const ApiPageDetails(),
  }) : this._internal(
          () => FullWordControl()
            ..namePattern = namePattern
            ..languageDomainObject = languageDomainObject
            ..pageDetails = pageDetails,
          from: fullWordControlProvider,
          name: r'fullWordControlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fullWordControlHash,
          dependencies: FullWordControlFamily._dependencies,
          allTransitiveDependencies:
              FullWordControlFamily._allTransitiveDependencies,
          namePattern: namePattern,
          languageDomainObject: languageDomainObject,
          pageDetails: pageDetails,
        );

  FullWordControlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.namePattern,
    required this.languageDomainObject,
    required this.pageDetails,
  }) : super.internal();

  final String namePattern;
  final LanguageDomainObject languageDomainObject;
  final ApiPageDetails pageDetails;

  @override
  FutureOr<ApiPage<FullWordPart>> runNotifierBuild(
    covariant FullWordControl notifier,
  ) {
    return notifier.build(
      namePattern,
      languageDomainObject,
      pageDetails: pageDetails,
    );
  }

  @override
  Override overrideWith(FullWordControl Function() create) {
    return ProviderOverride(
      origin: this,
      override: FullWordControlProvider._internal(
        () => create()
          ..namePattern = namePattern
          ..languageDomainObject = languageDomainObject
          ..pageDetails = pageDetails,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        namePattern: namePattern,
        languageDomainObject: languageDomainObject,
        pageDetails: pageDetails,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FullWordControl,
      ApiPage<FullWordPart>> createElement() {
    return _FullWordControlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FullWordControlProvider &&
        other.namePattern == namePattern &&
        other.languageDomainObject == languageDomainObject &&
        other.pageDetails == pageDetails;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, namePattern.hashCode);
    hash = _SystemHash.combine(hash, languageDomainObject.hashCode);
    hash = _SystemHash.combine(hash, pageDetails.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FullWordControlRef
    on AutoDisposeAsyncNotifierProviderRef<ApiPage<FullWordPart>> {
  /// The parameter `namePattern` of this provider.
  String get namePattern;

  /// The parameter `languageDomainObject` of this provider.
  LanguageDomainObject get languageDomainObject;

  /// The parameter `pageDetails` of this provider.
  ApiPageDetails get pageDetails;
}

class _FullWordControlProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FullWordControl,
        ApiPage<FullWordPart>> with FullWordControlRef {
  _FullWordControlProviderElement(super.provider);

  @override
  String get namePattern => (origin as FullWordControlProvider).namePattern;
  @override
  LanguageDomainObject get languageDomainObject =>
      (origin as FullWordControlProvider).languageDomainObject;
  @override
  ApiPageDetails get pageDetails =>
      (origin as FullWordControlProvider).pageDetails;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
