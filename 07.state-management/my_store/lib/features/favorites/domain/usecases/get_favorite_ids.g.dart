// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_favorite_ids.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getFavoriteIdsUseCase)
final getFavoriteIdsUseCaseProvider = GetFavoriteIdsUseCaseProvider._();

final class GetFavoriteIdsUseCaseProvider
    extends
        $FunctionalProvider<
          GetFavoriteIdsUseCase,
          GetFavoriteIdsUseCase,
          GetFavoriteIdsUseCase
        >
    with $Provider<GetFavoriteIdsUseCase> {
  GetFavoriteIdsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getFavoriteIdsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getFavoriteIdsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetFavoriteIdsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetFavoriteIdsUseCase create(Ref ref) {
    return getFavoriteIdsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetFavoriteIdsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetFavoriteIdsUseCase>(value),
    );
  }
}

String _$getFavoriteIdsUseCaseHash() =>
    r'f2a9063d83c40b30ee7c0ed0359a832c9c3e442f';
