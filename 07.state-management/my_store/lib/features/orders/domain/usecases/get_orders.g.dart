// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_orders.dart';

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
