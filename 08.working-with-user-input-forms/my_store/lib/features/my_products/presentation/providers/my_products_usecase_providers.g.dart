// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_products_usecase_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getMyProductsUseCase)
final getMyProductsUseCaseProvider = GetMyProductsUseCaseProvider._();

final class GetMyProductsUseCaseProvider
    extends
        $FunctionalProvider<
          GetMyProductsUseCase,
          GetMyProductsUseCase,
          GetMyProductsUseCase
        >
    with $Provider<GetMyProductsUseCase> {
  GetMyProductsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getMyProductsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getMyProductsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetMyProductsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetMyProductsUseCase create(Ref ref) {
    return getMyProductsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetMyProductsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetMyProductsUseCase>(value),
    );
  }
}

String _$getMyProductsUseCaseHash() =>
    r'6112d3bd162280405d7299a5362b761bb2349822';

@ProviderFor(deleteProductUseCase)
final deleteProductUseCaseProvider = DeleteProductUseCaseProvider._();

final class DeleteProductUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteProductUseCase,
          DeleteProductUseCase,
          DeleteProductUseCase
        >
    with $Provider<DeleteProductUseCase> {
  DeleteProductUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteProductUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteProductUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteProductUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteProductUseCase create(Ref ref) {
    return deleteProductUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteProductUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteProductUseCase>(value),
    );
  }
}

String _$deleteProductUseCaseHash() =>
    r'f3202f090556d71eb622ee0e2ecfb7f438debaf0';
