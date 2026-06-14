// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_favorite.dart';

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
