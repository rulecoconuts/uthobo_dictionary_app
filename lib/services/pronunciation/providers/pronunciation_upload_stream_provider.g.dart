// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pronunciation_upload_stream_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pronunciationUploadStreamHash() =>
    r'048e469056963860ce69d3e525e5a8c678f3e5bb';

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

abstract class _$PronunciationUploadStream
    extends BuildlessAutoDisposeStreamNotifier<PronunciationUploadStatus> {
  late final WordPartDomainObject wordPart;
  late final PronunciationPresignResult? specificPronunciationToWatch;

  Stream<PronunciationUploadStatus> build(
    WordPartDomainObject wordPart, {
    PronunciationPresignResult? specificPronunciationToWatch,
  });
}

/// See also [PronunciationUploadStream].
@ProviderFor(PronunciationUploadStream)
const pronunciationUploadStreamProvider = PronunciationUploadStreamFamily();

/// See also [PronunciationUploadStream].
class PronunciationUploadStreamFamily
    extends Family<AsyncValue<PronunciationUploadStatus>> {
  /// See also [PronunciationUploadStream].
  const PronunciationUploadStreamFamily();

  /// See also [PronunciationUploadStream].
  PronunciationUploadStreamProvider call(
    WordPartDomainObject wordPart, {
    PronunciationPresignResult? specificPronunciationToWatch,
  }) {
    return PronunciationUploadStreamProvider(
      wordPart,
      specificPronunciationToWatch: specificPronunciationToWatch,
    );
  }

  @override
  PronunciationUploadStreamProvider getProviderOverride(
    covariant PronunciationUploadStreamProvider provider,
  ) {
    return call(
      provider.wordPart,
      specificPronunciationToWatch: provider.specificPronunciationToWatch,
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
  String? get name => r'pronunciationUploadStreamProvider';
}

/// See also [PronunciationUploadStream].
class PronunciationUploadStreamProvider
    extends AutoDisposeStreamNotifierProviderImpl<PronunciationUploadStream,
        PronunciationUploadStatus> {
  /// See also [PronunciationUploadStream].
  PronunciationUploadStreamProvider(
    WordPartDomainObject wordPart, {
    PronunciationPresignResult? specificPronunciationToWatch,
  }) : this._internal(
          () => PronunciationUploadStream()
            ..wordPart = wordPart
            ..specificPronunciationToWatch = specificPronunciationToWatch,
          from: pronunciationUploadStreamProvider,
          name: r'pronunciationUploadStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pronunciationUploadStreamHash,
          dependencies: PronunciationUploadStreamFamily._dependencies,
          allTransitiveDependencies:
              PronunciationUploadStreamFamily._allTransitiveDependencies,
          wordPart: wordPart,
          specificPronunciationToWatch: specificPronunciationToWatch,
        );

  PronunciationUploadStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.wordPart,
    required this.specificPronunciationToWatch,
  }) : super.internal();

  final WordPartDomainObject wordPart;
  final PronunciationPresignResult? specificPronunciationToWatch;

  @override
  Stream<PronunciationUploadStatus> runNotifierBuild(
    covariant PronunciationUploadStream notifier,
  ) {
    return notifier.build(
      wordPart,
      specificPronunciationToWatch: specificPronunciationToWatch,
    );
  }

  @override
  Override overrideWith(PronunciationUploadStream Function() create) {
    return ProviderOverride(
      origin: this,
      override: PronunciationUploadStreamProvider._internal(
        () => create()
          ..wordPart = wordPart
          ..specificPronunciationToWatch = specificPronunciationToWatch,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        wordPart: wordPart,
        specificPronunciationToWatch: specificPronunciationToWatch,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<PronunciationUploadStream,
      PronunciationUploadStatus> createElement() {
    return _PronunciationUploadStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PronunciationUploadStreamProvider &&
        other.wordPart == wordPart &&
        other.specificPronunciationToWatch == specificPronunciationToWatch;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wordPart.hashCode);
    hash = _SystemHash.combine(hash, specificPronunciationToWatch.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PronunciationUploadStreamRef
    on AutoDisposeStreamNotifierProviderRef<PronunciationUploadStatus> {
  /// The parameter `wordPart` of this provider.
  WordPartDomainObject get wordPart;

  /// The parameter `specificPronunciationToWatch` of this provider.
  PronunciationPresignResult? get specificPronunciationToWatch;
}

class _PronunciationUploadStreamProviderElement
    extends AutoDisposeStreamNotifierProviderElement<PronunciationUploadStream,
        PronunciationUploadStatus> with PronunciationUploadStreamRef {
  _PronunciationUploadStreamProviderElement(super.provider);

  @override
  WordPartDomainObject get wordPart =>
      (origin as PronunciationUploadStreamProvider).wordPart;
  @override
  PronunciationPresignResult? get specificPronunciationToWatch =>
      (origin as PronunciationUploadStreamProvider)
          .specificPronunciationToWatch;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
