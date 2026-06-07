// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_cart_item.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
