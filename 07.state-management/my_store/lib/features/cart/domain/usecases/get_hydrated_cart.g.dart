// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_hydrated_cart.dart';

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
