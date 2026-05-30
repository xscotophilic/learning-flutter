import 'package:my_store/features/orders/domain/entities/order.dart';
import 'package:my_store/shared/cart/domain/entities/cart.dart';
import 'package:my_store/shared/cart/domain/entities/total.dart';
import 'package:my_store/shared/mock_server/data/mock_cart.dart';
import 'package:my_store/shared/mock_server/data/mock_orders.dart';
import 'package:my_store/shared/mock_server/data/mock_products.dart';
import 'package:my_store/shared/product/domain/entities/product_payload.dart';

class MockServer {
  MockServer._internal();

  factory MockServer() => _instance;

  static final MockServer _instance = MockServer._internal();

  static const Duration _kNetworkDelay = Duration(milliseconds: 1000);

  static Future<String> getHeroProductId() async {
    await Future<void>.delayed(_kNetworkDelay);
    return MockProductsData.heroProductId;
  }

  static Future<List<String>> getFeaturedProductIds() async {
    await Future<void>.delayed(_kNetworkDelay);
    return MockProductsData.featuredProductIds;
  }

  static Future<Map<String, dynamic>> getProductsByIds(List<String> ids) async {
    await Future<void>.delayed(_kNetworkDelay);

    return {
      'products': MockProductsData.products.where((product) {
        return ids.contains(product['id']);
      }).toList(),
    };
  }

  Future<Cart<CartItem>> getOrCreateCart() async {
    await Future<void>.delayed(_kNetworkDelay);

    final userId = 'mock-user-id';

    final Cart<CartItem>? cart = MockCartData.getActiveCart(userId);
    if (cart != null) {
      return cart;
    }

    return MockCartData.createCart(userId: userId, items: <CartItem>[]);
  }

  Future<Cart<CartItem>> updateItem({
    required String cartId,
    required String productId,
    required int quantity,
  }) async {
    final cart = MockCartData.getCartById(cartId);
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

      final response = await getProductsByIds([productId]);
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

    return MockCartData.updateCart(
      cart.copyWith(items: newItems, total: Total.fromCartItems(newItems)),
    );
  }

  static Future<List<Order>> getOrders() async {
    await Future<void>.delayed(_kNetworkDelay);
    return MockOrdersData.orders;
  }
}
