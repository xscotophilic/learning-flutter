import 'package:my_store/features/cart/domain/entities/cart.dart';
import 'package:my_store/features/cart/domain/entities/total.dart';
import 'package:my_store/features/cart/domain/usecases/get_hydrated_cart.dart';
import 'package:my_store/features/cart/domain/usecases/update_cart_item.dart';
import 'package:my_store/shared/orders/domain/usecases/place_order.dart';
import 'package:my_store/shared/product/presentation/providers/product_notifier.dart'
    show productProvider;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_notifier.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  Future<CartSnapshot<HydratedCartItem>> build() async {
    final getHydratedCart = ref.watch(getHydratedCartUseCaseProvider);
    final cart = await getHydratedCart.execute();

    return CartSnapshot(isMutating: false, cart: cart);
  }

  Future<void> placeOrder({
    required String paymentId,
    required String paymentMethodId,
  }) async {
    final snapshot = state.value ?? await future;
    if (snapshot.isMutating) return;

    final placeOrder = ref.read(placeOrderUseCaseProvider);

    state = AsyncData(snapshot.copyWith(isMutating: true));
    try {
      await placeOrder.execute(
        cartId: snapshot.cart.id,
        paymentId: paymentId,
        paymentMethodId: paymentMethodId,
      );
      state = AsyncData(snapshot.copyWith(isMutating: false));
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncData(snapshot.copyWith(isMutating: false));
      state = AsyncError(e, st);
    }
  }

  Future<void> addItem(String productId) async {
    final existing = await _getItemByID(productId);

    return _updateQuantity(productId, (existing?.cartItem.quantity ?? 0) + 1);
  }

  Future<void> removeItem(String productId) async {
    final existing = await _getItemByID(productId);

    if (existing != null) {
      return _updateQuantity(productId, 0);
    }
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    final existing = await _getItemByID(productId);

    if (existing != null) {
      return _updateQuantity(productId, quantity);
    }
  }

  Future<HydratedCartItem?> _getItemByID(String productId) async {
    final snapshot = state.value ?? await future;
    if (snapshot.isMutating) return null;

    return snapshot.cart.items.where((i) {
      return i.cartItem.productId == productId;
    }).firstOrNull;
  }

  Cart<HydratedCartItem> _createOptimisticCart({
    required CartSnapshot<HydratedCartItem> snapshot,
    required String productId,
    required int quantity,
  }) {
    final List<HydratedCartItem> optimisticItems = [];
    for (final item in snapshot.cart.items) {
      if (item.product.id == productId) {
        if (quantity > 0) {
          optimisticItems.add(
            HydratedCartItem(
              cartItem: item.cartItem.copyWith(quantity: quantity),
              product: item.product,
            ),
          );
        }
      } else {
        optimisticItems.add(item);
      }
    }

    final optimisticTotal = Total.fromCartItems(
      optimisticItems.map((item) => item.cartItem).toList(),
    );

    return snapshot.cart.copyWith(
      items: optimisticItems,
      total: optimisticTotal,
    );
  }

  Future<void> _updateQuantity(String productId, int quantity) async {
    final snapshot = state.value ?? await future;
    if (snapshot.isMutating) return;

    final optimisticCart = _createOptimisticCart(
      snapshot: snapshot,
      productId: productId,
      quantity: quantity,
    );

    state = AsyncData(
      snapshot.copyWith(isMutating: true, cart: optimisticCart),
    );

    final updateCartItem = ref.read(updateCartItemUseCaseProvider);
    try {
      final updatedCart = await updateCartItem.execute(
        cartId: optimisticCart.id,
        productId: productId,
        quantity: quantity,
        optimisticCartTotal: optimisticCart.total,
      );

      // If the total differs, product notifiers are invalidated,
      // and then they re-fetch to show the accurate data.
      if (updatedCart.total != optimisticCart.total) {
        for (final item in updatedCart.items) {
          ref.invalidate(productProvider(item.cartItem.productId));
        }
      }

      state = AsyncData(CartSnapshot(isMutating: false, cart: updatedCart));
    } catch (e, st) {
      state = AsyncData(snapshot.copyWith(isMutating: false));
      state = AsyncError(e, st);
    }
  }
}
