// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CartNotifier)
final cartProvider = CartNotifierProvider._();

final class CartNotifierProvider
    extends
        $AsyncNotifierProvider<CartNotifier, CartSnapshot<HydratedCartItem>> {
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

String _$cartNotifierHash() => r'2533d93f012632daa509ff95a6ef922060f71f73';

abstract class _$CartNotifier
    extends $AsyncNotifier<CartSnapshot<HydratedCartItem>> {
  FutureOr<CartSnapshot<HydratedCartItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<CartSnapshot<HydratedCartItem>>,
              CartSnapshot<HydratedCartItem>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CartSnapshot<HydratedCartItem>>,
                CartSnapshot<HydratedCartItem>
              >,
              AsyncValue<CartSnapshot<HydratedCartItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
