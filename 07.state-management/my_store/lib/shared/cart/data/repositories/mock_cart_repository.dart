import 'package:my_store/core/extensions/iterable_extensions.dart';
import 'package:my_store/shared/cart/data/store/mock_cart_store.dart';
import 'package:my_store/shared/cart/domain/entities/cart.dart';
import 'package:my_store/shared/cart/domain/entities/total.dart';
import 'package:my_store/shared/cart/domain/exceptions/cart_exceptions.dart';
import 'package:my_store/shared/cart/domain/repositories/cart_repository.dart';
import 'package:my_store/shared/data/mock_products.dart';

final class MockCartRepository implements CartRepository {
  MockCartRepository();

  final MockCartStore _store = MockCartStore();
  static const Duration _kNetworkDelay = Duration(milliseconds: 250);

  @override
  Future<Cart<CartItem>> getOrCreateCart() async {
    await Future<void>.delayed(_kNetworkDelay);

    final cart = await _callApiToGetOrCreateCart();

    return cart;
  }

  @override
  Future<Cart<CartItem>> updateItem({
    required String cartId,
    required String productId,
    required int quantity,
  }) async {
    await Future<void>.delayed(_kNetworkDelay);

    final cart = await _callApiToUpdateItem(
      cartId: cartId,
      productId: productId,
      quantity: quantity,
    );

    return cart;
  }

  Future<Cart<CartItem>> _callApiToGetOrCreateCart() async {
    // Note: this is a mock repository, so we perform the operation locally,
    // for the actual implementation, you should call api with your user id

    final userId = 'mock-user-id';

    final Cart<CartItem>? cart = _store.carts.values.firstWhereOrNull(
      (c) => c.status == CartStatus.active && c.ownerId == userId,
    );

    if (cart != null) {
      return cart;
    }

    final String cartId = 'cart-${DateTime.now().millisecondsSinceEpoch}';

    final items = <CartItem>[];
    final total = Total.fromCartItems(items);

    return _store.carts[cartId] ??= Cart(
      id: cartId,
      ownerId: userId,
      createdAt: DateTime.now(),
      status: CartStatus.active,
      items: items,
      total: total,
    );
  }

  Future<Cart<CartItem>> _callApiToUpdateItem({
    required String cartId,
    required String productId,
    required int quantity,
  }) async {
    // Note: this is a mock repository, so we perform the update locally,
    // for the actual implementation, you should call api with your cart id, product id, and quantity

    final cart = _store.carts[cartId];
    if (cart == null) {
      throw const CartNotFoundException();
    }

    final newItems = List<CartItem>.from(cart.items);

    if (quantity <= 0) {
      newItems.removeWhere((i) => i.productId == productId);
    } else {
      final existingIndex = newItems.indexWhere(
        (i) => i.productId == productId,
      );

      final product = MockProductsData.products.firstWhereOrNull(
        (p) => p.id == productId,
      );
      if (product == null) {
        throw Exception('Product not found');
      }

      if (existingIndex < 0) {
        newItems.add(
          CartItem(
            productId: productId,
            unitPrice: product.price,
            quantity: quantity,
          ),
        );
      } else {
        newItems[existingIndex] = CartItem(
          productId: productId,
          unitPrice: product.price,
          quantity: quantity,
        );
      }
    }

    return _store.carts[cartId] = cart.copyWith(
      items: newItems,
      total: Total.fromCartItems(newItems),
    );
  }
}
