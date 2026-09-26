// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_usecase_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getHomePageDataUseCase)
final getHomePageDataUseCaseProvider = GetHomePageDataUseCaseProvider._();

final class GetHomePageDataUseCaseProvider
    extends
        $FunctionalProvider<
          GetHomePageDataUseCase,
          GetHomePageDataUseCase,
          GetHomePageDataUseCase
        >
    with $Provider<GetHomePageDataUseCase> {
  GetHomePageDataUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getHomePageDataUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getHomePageDataUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetHomePageDataUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetHomePageDataUseCase create(Ref ref) {
    return getHomePageDataUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetHomePageDataUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetHomePageDataUseCase>(value),
    );
  }
}

String _$getHomePageDataUseCaseHash() =>
    r'e5e46aa6acf145733d61a4b54674510040606e5a';
