// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_control.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$languageControlHash() => r'8e8d12648afe0224f538007a878ac67cbc367812';

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

abstract class _$LanguageControl
    extends BuildlessAutoDisposeAsyncNotifier<ApiPage<LanguageDomainObject>> {
  late final String namePattern;
  late final ApiPageDetails pageDetails;

  FutureOr<ApiPage<LanguageDomainObject>> build(
    String namePattern,
    ApiPageDetails pageDetails,
  );
}

/// See also [LanguageControl].
@ProviderFor(LanguageControl)
const languageControlProvider = LanguageControlFamily();

/// See also [LanguageControl].
class LanguageControlFamily
    extends Family<AsyncValue<ApiPage<LanguageDomainObject>>> {
  /// See also [LanguageControl].
  const LanguageControlFamily();

  /// See also [LanguageControl].
  LanguageControlProvider call(
    String namePattern,
    ApiPageDetails pageDetails,
  ) {
    return LanguageControlProvider(
      namePattern,
      pageDetails,
    );
  }

  @override
  LanguageControlProvider getProviderOverride(
    covariant LanguageControlProvider provider,
  ) {
    return call(
      provider.namePattern,
      provider.pageDetails,
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
  String? get name => r'languageControlProvider';
}

/// See also [LanguageControl].
class LanguageControlProvider extends AutoDisposeAsyncNotifierProviderImpl<
    LanguageControl, ApiPage<LanguageDomainObject>> {
  /// See also [LanguageControl].
  LanguageControlProvider(
    String namePattern,
    ApiPageDetails pageDetails,
  ) : this._internal(
          () => LanguageControl()
            ..namePattern = namePattern
            ..pageDetails = pageDetails,
          from: languageControlProvider,
          name: r'languageControlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$languageControlHash,
          dependencies: LanguageControlFamily._dependencies,
          allTransitiveDependencies:
              LanguageControlFamily._allTransitiveDependencies,
          namePattern: namePattern,
          pageDetails: pageDetails,
        );

  LanguageControlProvider._internal(
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
  FutureOr<ApiPage<LanguageDomainObject>> runNotifierBuild(
    covariant LanguageControl notifier,
  ) {
    return notifier.build(
      namePattern,
      pageDetails,
    );
  }

  @override
  Override overrideWith(LanguageControl Function() create) {
    return ProviderOverride(
      origin: this,
      override: LanguageControlProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<LanguageControl,
      ApiPage<LanguageDomainObject>> createElement() {
    return _LanguageControlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LanguageControlProvider &&
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

mixin LanguageControlRef
    on AutoDisposeAsyncNotifierProviderRef<ApiPage<LanguageDomainObject>> {
  /// The parameter `namePattern` of this provider.
  String get namePattern;

  /// The parameter `pageDetails` of this provider.
  ApiPageDetails get pageDetails;
}

class _LanguageControlProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<LanguageControl,
        ApiPage<LanguageDomainObject>> with LanguageControlRef {
  _LanguageControlProviderElement(super.provider);

  @override
  String get namePattern => (origin as LanguageControlProvider).namePattern;
  @override
  ApiPageDetails get pageDetails =>
      (origin as LanguageControlProvider).pageDetails;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
