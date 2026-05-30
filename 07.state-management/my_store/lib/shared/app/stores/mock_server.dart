import 'package:my_store/core/extensions/iterable_extensions.dart';
import 'package:my_store/shared/app/data_sources/mock_products.dart';
import 'package:my_store/shared/cart/domain/entities/cart.dart';
import 'package:my_store/shared/cart/domain/entities/total.dart';
import 'package:my_store/shared/product/domain/entities/product_payload.dart';

class MockServer {
  MockServer._internal();

  factory MockServer() => _instance;

  static final MockServer _instance = MockServer._internal();

  final Map<String, Cart<CartItem>> _carts = {};

  Future<Cart<CartItem>> getOrCreateCart() async {
    // Note: this is a mock repository, so we perform the operation locally,
    // for the actual implementation, you should call api with your user id

    final userId = 'mock-user-id';

    final Cart<CartItem>? cart = _carts.values.firstWhereOrNull(
      (c) => c.status == CartStatus.active && c.ownerId == userId,
    );

    if (cart != null) {
      return cart;
    }

    final String cartId = 'cart-${DateTime.now().millisecondsSinceEpoch}';

    final items = <CartItem>[];
    final total = Total.fromCartItems(items);

    return _carts[cartId] ??= Cart(
      id: cartId,
      ownerId: userId,
      createdAt: DateTime.now(),
      status: CartStatus.active,
      items: items,
      total: total,
    );
  }

  Future<Cart<CartItem>> updateItem({
    required String cartId,
    required String productId,
    required int quantity,
  }) async {
    // Note: this is a mock repository, so we perform the update locally,
    // for the actual implementation, you should call api with your cart id, product id, and quantity

    final cart = _carts[cartId];
    if (cart == null) {
      throw Exception('cart not found');
    }

    final newItems = List<CartItem>.from(cart.items);

    if (quantity <= 0) {
      newItems.removeWhere((i) => i.productId == productId);
    } else {
      final existingIndex = newItems.indexWhere(
        (i) => i.productId == productId,
      );

      final response = await MockProductsData.getProductsByIds([productId]);
      final product = ProductsPayload.fromJson(response).products.firstOrNull;

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

    return _carts[cartId] = cart.copyWith(
      items: newItems,
      total: Total.fromCartItems(newItems),
    );
  }
}
