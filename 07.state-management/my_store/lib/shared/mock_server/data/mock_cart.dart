import 'package:my_store/core/extensions/iterable_extensions.dart';
import 'package:my_store/shared/cart/domain/entities/cart.dart';
import 'package:my_store/shared/cart/domain/entities/total.dart';

class MockCartData {
  const MockCartData._();

  static final Map<String, Cart<CartItem>> _carts = {};

  static Cart<CartItem>? getActiveCart(String userId) {
    return _carts.values.firstWhereOrNull(
      (c) => c.status == CartStatus.active && c.ownerId == userId,
    );
  }

  static Cart<CartItem> createCart({
    required String userId,
    required List<CartItem> items,
  }) {
    final String cartId = 'cart-${DateTime.now().millisecondsSinceEpoch}';
    final total = Total.fromCartItems(items);

    return _carts[cartId] = Cart<CartItem>(
      id: cartId,
      ownerId: userId,
      items: items,
      total: total,
      status: CartStatus.active,
      createdAt: DateTime.now(),
    );
  }

  static Cart<CartItem>? getCartById(String cartId) {
    return _carts[cartId];
  }

  static Cart<CartItem> updateCart(Cart<CartItem> cart) {
    return _carts[cart.id] = cart;
  }
}
