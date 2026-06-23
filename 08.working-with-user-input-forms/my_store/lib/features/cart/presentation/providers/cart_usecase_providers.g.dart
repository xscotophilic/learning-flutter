// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_usecase_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getHydratedCartUseCase)
final getHydratedCartUseCaseProvider = GetHydratedCartUseCaseProvider._();

final class GetHydratedCartUseCaseProvider
    extends
        $FunctionalProvider<
          GetHydratedCartUseCase,
          GetHydratedCartUseCase,
          GetHydratedCartUseCase
        >
    with $Provider<GetHydratedCartUseCase> {
  GetHydratedCartUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getHydratedCartUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getHydratedCartUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetHydratedCartUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetHydratedCartUseCase create(Ref ref) {
    return getHydratedCartUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetHydratedCartUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetHydratedCartUseCase>(value),
    );
  }
}

String _$getHydratedCartUseCaseHash() =>
    r'dc25ebcaa7b50f1041c3cf0ff72cb96d6239ebc2';

@ProviderFor(updateCartItemUseCase)
final updateCartItemUseCaseProvider = UpdateCartItemUseCaseProvider._();

final class UpdateCartItemUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateCartItemUseCase,
          UpdateCartItemUseCase,
          UpdateCartItemUseCase
        >
    with $Provider<UpdateCartItemUseCase> {
  UpdateCartItemUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateCartItemUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateCartItemUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateCartItemUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateCartItemUseCase create(Ref ref) {
    return updateCartItemUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateCartItemUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateCartItemUseCase>(value),
    );
  }
}

String _$updateCartItemUseCaseHash() =>
    r'a406b8bc0b30261c0bcc4de04a60213168a82eb1';
