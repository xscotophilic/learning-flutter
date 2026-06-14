// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_usecase_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(addFavoriteUseCase)
final addFavoriteUseCaseProvider = AddFavoriteUseCaseProvider._();

final class AddFavoriteUseCaseProvider
    extends
        $FunctionalProvider<
          AddFavoriteUseCase,
          AddFavoriteUseCase,
          AddFavoriteUseCase
        >
    with $Provider<AddFavoriteUseCase> {
  AddFavoriteUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addFavoriteUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addFavoriteUseCaseHash();

  @$internal
  @override
  $ProviderElement<AddFavoriteUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AddFavoriteUseCase create(Ref ref) {
    return addFavoriteUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddFavoriteUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddFavoriteUseCase>(value),
    );
  }
}

String _$addFavoriteUseCaseHash() =>
    r'd80fe2f951a5e07e51091ca30ff430c385aba5bd';

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

@ProviderFor(removeFavoriteUseCase)
final removeFavoriteUseCaseProvider = RemoveFavoriteUseCaseProvider._();

final class RemoveFavoriteUseCaseProvider
    extends
        $FunctionalProvider<
          RemoveFavoriteUseCase,
          RemoveFavoriteUseCase,
          RemoveFavoriteUseCase
        >
    with $Provider<RemoveFavoriteUseCase> {
  RemoveFavoriteUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'removeFavoriteUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$removeFavoriteUseCaseHash();

  @$internal
  @override
  $ProviderElement<RemoveFavoriteUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemoveFavoriteUseCase create(Ref ref) {
    return removeFavoriteUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoveFavoriteUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoveFavoriteUseCase>(value),
    );
  }
}

String _$removeFavoriteUseCaseHash() =>
    r'cbef7686a25d01f8923672ab1ab6c4f2c7e9a147';
