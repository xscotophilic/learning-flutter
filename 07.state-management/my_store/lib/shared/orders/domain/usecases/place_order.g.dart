// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_order.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
