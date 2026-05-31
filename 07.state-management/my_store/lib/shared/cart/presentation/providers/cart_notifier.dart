import 'package:my_store/features/orders/data/repositories/orders_repository_provider.dart';
import 'package:my_store/shared/cart/data/repositories/cart_repository_provider.dart';
import 'package:my_store/shared/cart/domain/entities/cart.dart';
import 'package:my_store/shared/cart/domain/entities/total.dart';
import 'package:my_store/shared/product/data/repositories/product_repository_provider.dart';
import 'package:my_store/shared/product/presentation/providers/product_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_notifier.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  Future<CartSnapshot<HydratedCartItem>> build() async {
    final cartRepository = ref.watch(cartRepositoryProvider);
    final productRepository = ref.watch(productRepositoryProvider);

    final cart = await cartRepository.getOrCreateCart();

    final products = await productRepository.getProductsByIds(
      productIds: cart.items.map((i) => i.productId).toList(),
    );

    final productMap = {for (final p in products) p.id: p};

    final hydratedItems = cart.items.map((cartItem) {
      final product = productMap[cartItem.productId];
      if (product == null) {
        throw Exception('Product ${cartItem.productId} not found');
      }
      return HydratedCartItem(cartItem: cartItem, product: product);
    }).toList();

    return CartSnapshot(
      isMutating: false,
      cart: Cart<HydratedCartItem>(
        id: cart.id,
        ownerId: cart.ownerId,
        createdAt: cart.createdAt,
        status: cart.status,
        items: hydratedItems,
        total: cart.total,
      ),
    );
  }

  Future<void> placeOrder({
    required String paymentId,
    required String paymentMethodId,
  }) async {
    final snapshot = state.value ?? await future;
    if (snapshot.isMutating) return;

    final orderRepository = ref.read(ordersRepositoryProvider);

    state = AsyncData(snapshot.copyWith(isMutating: true));
    try {
      await orderRepository.placeOrder(
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

    final cartRepository = ref.read(cartRepositoryProvider);
    final productRepository = ref.read(productRepositoryProvider);
    try {
      final updatedRawCart = await cartRepository.updateItem(
        cartId: optimisticCart.id,
        productId: productId,
        quantity: quantity,
      );

      final products = await productRepository.getProductsByIds(
        productIds: updatedRawCart.items.map((i) => i.productId).toList(),
        skipCache: true,
      );
      final productMap = {for (final p in products) p.id: p};

      final hydratedItems = updatedRawCart.items.map((cartItem) {
        final product = productMap[cartItem.productId];
        if (product == null) {
          throw Exception('Product ${cartItem.productId} not found');
        }
        return HydratedCartItem(cartItem: cartItem, product: product);
      }).toList();

      // For products that are in the cart,
      // invalidate their providers to ensure they get fresh data.
      for (final item in updatedRawCart.items) {
        ref.invalidate(productProvider(item.productId));
      }

      state = AsyncData(
        CartSnapshot(
          isMutating: false,
          cart: Cart<HydratedCartItem>(
            id: updatedRawCart.id,
            ownerId: updatedRawCart.ownerId,
            createdAt: updatedRawCart.createdAt,
            status: updatedRawCart.status,
            items: hydratedItems,
            total: updatedRawCart.total,
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncData(snapshot.copyWith(isMutating: false));
      state = AsyncError(e, st);
    }
  }
}
