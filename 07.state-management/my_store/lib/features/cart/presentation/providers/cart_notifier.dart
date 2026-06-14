import 'package:my_store/features/cart/domain/entities/cart.dart';
import 'package:my_store/features/cart/domain/usecases/get_hydrated_cart.dart';
import 'package:my_store/features/cart/domain/usecases/update_cart_item.dart';
import 'package:my_store/features/orders/domain/usecases/place_order.dart';
import 'package:my_store/features/product/presentation/providers/product_notifier.dart'
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
      // Payment details should be handled dynamically when the app adds a payment feature.
      // For now, this is generated here instead of leaking orchestration to the UI.
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

  Future<void> _updateQuantity(String productId, int quantity) async {
    final snapshot = state.value ?? await future;
    if (snapshot.isMutating) return;

    final optimisticCart = snapshot.cart.updateItemQuantity(
      productId,
      quantity,
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
