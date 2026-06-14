// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_product_by_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getProductByIdUseCase)
final getProductByIdUseCaseProvider = GetProductByIdUseCaseProvider._();

final class GetProductByIdUseCaseProvider
    extends
        $FunctionalProvider<
          GetProductByIdUseCase,
          GetProductByIdUseCase,
          GetProductByIdUseCase
        >
    with $Provider<GetProductByIdUseCase> {
  GetProductByIdUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getProductByIdUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getProductByIdUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetProductByIdUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetProductByIdUseCase create(Ref ref) {
    return getProductByIdUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetProductByIdUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetProductByIdUseCase>(value),
    );
  }
}

String _$getProductByIdUseCaseHash() =>
    r'501f04952ce689a7bc2e466daa8b4aecb49e5a44';
