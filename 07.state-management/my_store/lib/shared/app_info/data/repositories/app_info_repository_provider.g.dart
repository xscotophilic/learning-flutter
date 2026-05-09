// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appInfoRepository)
final appInfoRepositoryProvider = AppInfoRepositoryProvider._();

final class AppInfoRepositoryProvider
    extends
        $FunctionalProvider<
          AppInfoRepository,
          AppInfoRepository,
          AppInfoRepository
        >
    with $Provider<AppInfoRepository> {
  AppInfoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appInfoRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appInfoRepositoryHash();

  @$internal
  @override
  $ProviderElement<AppInfoRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppInfoRepository create(Ref ref) {
    return appInfoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppInfoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppInfoRepository>(value),
    );
  }
}

String _$appInfoRepositoryHash() => r'2ed9c9cef9c5ebfc9c7f67b2effb76e1b64f6531';
