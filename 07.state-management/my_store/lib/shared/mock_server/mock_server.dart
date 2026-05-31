import 'package:my_store/core/extensions/iterable_extensions.dart';
import 'package:my_store/shared/mock_server/data/mock_cart.dart';
import 'package:my_store/shared/mock_server/data/mock_orders.dart';
import 'package:my_store/shared/mock_server/data/mock_products.dart';

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

  Future<Map<String, dynamic>> getOrCreateCart() async {
    await Future<void>.delayed(_kNetworkDelay);

    final userId = 'mock-user-id';

    final Map<String, dynamic>? payload = MockCartData.getActiveCart(userId);
    if (payload?['cart'] != null) {
      return payload as Map<String, dynamic>;
    }

    return MockCartData.createCart(
      userId: userId,
      items: <Map<String, dynamic>>[],
      total: <String, dynamic>{
        'subtotal': 0,
        'discount': 0,
        'total': 0,
        'currency': '',
      },
    );
  }

  Future<Map<String, dynamic>> updateItem({
    required String cartId,
    required String productId,
    required int quantity,
  }) async {
    final response = MockCartData.getCartById(cartId);
    if (response?['cart'] == null) {
      throw Exception('cart not found');
    }

    final cart = response?['cart'] as Map<String, dynamic>;

    final newItems = cart['items'] as List<Map<String, dynamic>>;

    if (quantity <= 0) {
      newItems.removeWhere((i) => i['product_id'] == productId);
    } else {
      final existingIndex = newItems.indexWhere(
        (i) => i['product_id'] == productId,
      );

      final product = MockProductsData.products.firstWhereOrNull((product) {
        return product['id'] == productId;
      });

      if (product == null) {
        throw Exception('product not found');
      }

      if (existingIndex < 0) {
        newItems.add({
          'product_id': productId,
          'unit_price': product['price'],
          'quantity': quantity,
        });
      } else {
        newItems[existingIndex] = {
          'product_id': productId,
          'unit_price': product['price'],
          'quantity': quantity,
        };
      }
    }

    double amount = 0;
    double discount = 0;
    String? currency;

    for (final item in newItems) {
      final unitPrice = item['unit_price'] as Map<String, dynamic>;

      if (currency == null) {
        currency = unitPrice['currency'] as String?;
      } else if (currency != unitPrice['currency']) {
        currency = 'invalid';
      }

      final double currentItemAmount =
          ((unitPrice['amount'] * item['quantity']) as num).toDouble();
      final double discountPercent =
          (unitPrice['discount_percent'] as num?)?.toDouble() ?? 0.0;
      final double currentItemDiscount = discountPercent <= 0.0
          ? 0
          : ((discountPercent / 100) * currentItemAmount);

      amount += currentItemAmount;
      discount += currentItemDiscount;
    }

    return MockCartData.updateCart(
      cartId: cartId,
      items: newItems,
      total: {
        'subtotal': amount,
        'discount': discount,
        'total': amount - discount,
        'currency': currency ?? '',
      },
    );
  }

  static Future<void> placeOrder({
    required String cartId,
    required String paymentId,
    required String paymentMethodId,
  }) async {
    await Future<void>.delayed(_kNetworkDelay);

    final response = MockCartData.getCartById(cartId);
    if (response?['cart'] == null ||
        response?['cart']['status'] == 'completed') {
      throw Exception('invalid cart');
    }
    final cart = response?['cart'] as Map<String, dynamic>;

    final lineItems = <Map<String, dynamic>>[];
    for (final item in (cart['items'] as List<Map<String, dynamic>>)) {
      final unitPrice = item['unit_price'] as Map<String, dynamic>;
      lineItems.add({
        'product_id': item['product_id'],
        'quantity': item['quantity'],
        'purchase_price': unitPrice,
      });
    }

    MockOrdersData.createOrder(items: lineItems);

    MockCartData.updateCartStatus(cartId, 'completed');

    return;
  }

  static Future<Map<String, dynamic>?> getOrders() async {
    await Future<void>.delayed(_kNetworkDelay);
    return MockOrdersData.getOrders();
  }
}
