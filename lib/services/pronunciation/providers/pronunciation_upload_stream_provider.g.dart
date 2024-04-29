// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pronunciation_upload_stream_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pronunciationUploadStreamHash() =>
    r'57f5ba15b8dbd3d9583817c1f4edd0f65dbeb7d0';

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

  Stream<PronunciationUploadStatus> build(
    WordPartDomainObject wordPart,
  );
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
    WordPartDomainObject wordPart,
  ) {
    return PronunciationUploadStreamProvider(
      wordPart,
    );
  }

  @override
  PronunciationUploadStreamProvider getProviderOverride(
    covariant PronunciationUploadStreamProvider provider,
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
  String? get name => r'pronunciationUploadStreamProvider';
}

/// See also [PronunciationUploadStream].
class PronunciationUploadStreamProvider
    extends AutoDisposeStreamNotifierProviderImpl<PronunciationUploadStream,
        PronunciationUploadStatus> {
  /// See also [PronunciationUploadStream].
  PronunciationUploadStreamProvider(
    WordPartDomainObject wordPart,
  ) : this._internal(
          () => PronunciationUploadStream()..wordPart = wordPart,
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
        );

  PronunciationUploadStreamProvider._internal(
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
  Stream<PronunciationUploadStatus> runNotifierBuild(
    covariant PronunciationUploadStream notifier,
  ) {
    return notifier.build(
      wordPart,
    );
  }

  @override
  Override overrideWith(PronunciationUploadStream Function() create) {
    return ProviderOverride(
      origin: this,
      override: PronunciationUploadStreamProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<PronunciationUploadStream,
      PronunciationUploadStatus> createElement() {
    return _PronunciationUploadStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PronunciationUploadStreamProvider &&
        other.wordPart == wordPart;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wordPart.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PronunciationUploadStreamRef
    on AutoDisposeStreamNotifierProviderRef<PronunciationUploadStatus> {
  /// The parameter `wordPart` of this provider.
  WordPartDomainObject get wordPart;
}

class _PronunciationUploadStreamProviderElement
    extends AutoDisposeStreamNotifierProviderElement<PronunciationUploadStream,
        PronunciationUploadStatus> with PronunciationUploadStreamRef {
  _PronunciationUploadStreamProviderElement(super.provider);

  @override
  WordPartDomainObject get wordPart =>
      (origin as PronunciationUploadStreamProvider).wordPart;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
