// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_favorite.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
