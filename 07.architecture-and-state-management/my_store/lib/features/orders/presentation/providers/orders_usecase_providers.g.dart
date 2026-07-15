// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_usecase_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getOrdersUseCase)
final getOrdersUseCaseProvider = GetOrdersUseCaseProvider._();

final class GetOrdersUseCaseProvider
    extends
        $FunctionalProvider<
          GetOrdersUseCase,
          GetOrdersUseCase,
          GetOrdersUseCase
        >
    with $Provider<GetOrdersUseCase> {
  GetOrdersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getOrdersUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getOrdersUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetOrdersUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetOrdersUseCase create(Ref ref) {
    return getOrdersUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetOrdersUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetOrdersUseCase>(value),
    );
  }
}

String _$getOrdersUseCaseHash() => r'2070f745297c1a9283b13fdd08aa8cb935f8fa12';

@ProviderFor(placeOrderUseCase)
final placeOrderUseCaseProvider = PlaceOrderUseCaseProvider._();

final class PlaceOrderUseCaseProvider
    extends
        $FunctionalProvider<
          PlaceOrderUseCase,
          PlaceOrderUseCase,
          PlaceOrderUseCase
        >
    with $Provider<PlaceOrderUseCase> {
  PlaceOrderUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placeOrderUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placeOrderUseCaseHash();

  @$internal
  @override
  $ProviderElement<PlaceOrderUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PlaceOrderUseCase create(Ref ref) {
    return placeOrderUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaceOrderUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaceOrderUseCase>(value),
    );
  }
}

String _$placeOrderUseCaseHash() => r'035b1d52dca40876dc4bf726c4a3f4640d697f8d';
