// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_CartState)
final _cartStateProvider = _CartStateProvider._();

final class _CartStateProvider
    extends $AsyncNotifierProvider<_CartState, Cart<CartItem>> {
  _CartStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_cartStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_cartStateHash();

  @$internal
  @override
  _CartState create() => _CartState();
}

String _$_cartStateHash() => r'b2e22d89fd1638c8320f65c70dc667a09a201933';

abstract class _$CartState extends $AsyncNotifier<Cart<CartItem>> {
  FutureOr<Cart<CartItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Cart<CartItem>>, Cart<CartItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Cart<CartItem>>, Cart<CartItem>>,
              AsyncValue<Cart<CartItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(CartNotifier)
final cartProvider = CartNotifierProvider._();

final class CartNotifierProvider
    extends $AsyncNotifierProvider<CartNotifier, Cart<HydratedCartItem>> {
  CartNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartNotifierHash();

  @$internal
  @override
  CartNotifier create() => CartNotifier();
}

String _$cartNotifierHash() => r'a21ef612b8dfc43c9cdbf56f5483bc19be9343f8';

abstract class _$CartNotifier extends $AsyncNotifier<Cart<HydratedCartItem>> {
  FutureOr<Cart<HydratedCartItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<Cart<HydratedCartItem>>, Cart<HydratedCartItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Cart<HydratedCartItem>>,
                Cart<HydratedCartItem>
              >,
              AsyncValue<Cart<HydratedCartItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
