import 'dart:math' as math;

import 'package:my_store/core/extensions/iterable_extensions.dart';
import 'package:my_store/mock_server/data/mock_cart.dart';
import 'package:my_store/mock_server/data/mock_orders.dart';
import 'package:my_store/mock_server/data/mock_products.dart';

class MockServer {
  MockServer._internal();

  factory MockServer() => _instance;

  static final MockServer _instance = MockServer._internal();

  static const Duration _kNetworkDelay = Duration(milliseconds: 1000);

  static Future<Map<String, dynamic>> getHeroProduct() async {
    await Future<void>.delayed(_kNetworkDelay);
    return MockProductsData.products.first;
  }

  static Future<Map<String, dynamic>> getFeaturedProducts() async {
    await Future<void>.delayed(_kNetworkDelay);
    return {'products': MockProductsData.products};
  }

  static Future<Map<String, dynamic>> getProductsByIds(List<String> ids) async {
    await Future<void>.delayed(_kNetworkDelay);

    return {
      'products': MockProductsData.products.where((product) {
        return ids.contains(product['id']);
      }).toList(),
    };
  }

  static Future<Map<String, dynamic>> getMyProducts() async {
    await Future<void>.delayed(_kNetworkDelay);

    final userId = 'demo-user';

    return {
      'products': MockProductsData.products.where((product) {
        return product['creator_id'] == userId;
      }).toList(),
    };
  }

  static Future<Map<String, dynamic>> createProduct({
    required Map<String, dynamic> data,
  }) async {
    await Future<void>.delayed(_kNetworkDelay);

    final userId = 'demo-user';

    final name = data['name'] as String?;
    final description = data['description'] as String?;
    final price = data['price'] as Object?;
    final imageUrl = data['image_url'] as String?;

    if (name == null ||
        description == null ||
        price == null ||
        imageUrl == null) {
      throw Exception('Invalid product data');
    }

    final product = {
      'id': math.Random().nextInt(1000000).toString(),
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'creator_id': userId,
    };

    MockProductsData.products.add(product);
    return product;
  }

  static Future<Map<String, dynamic>> updateProduct({
    required Map<String, dynamic> data,
  }) async {
    await Future<void>.delayed(_kNetworkDelay);

    final userId = 'demo-user';

    final index = MockProductsData.products.indexWhere(
      (p) => p['id'] == data['id'],
    );
    if (index < 0) {
      throw Exception('product not found');
    }

    final existingProduct = MockProductsData.products[index];
    if (existingProduct['creator_id'] != userId) {
      throw Exception('permission denied');
    }

    final updatedProduct = {
      'id': existingProduct['id'],
      'name': data['name'] ?? existingProduct['name'],
      'description': data['description'] ?? existingProduct['description'],
      'price': data['price'] ?? existingProduct['price'],
      'image_url': data['image_url'] ?? existingProduct['image_url'],
      'creator_id': userId,
    };

    MockProductsData.products[index] = updatedProduct;
    return updatedProduct;
  }

  static Future<void> deleteProduct({required String id}) async {
    await Future<void>.delayed(_kNetworkDelay);

    final userId = 'demo-user';

    final index = MockProductsData.products.indexWhere((p) => p['id'] == id);
    if (index < 0) {
      throw Exception('product not found');
    }

    final existingProduct = MockProductsData.products[index];
    if (existingProduct['creator_id'] != userId) {
      throw Exception('permission denied');
    }

    MockProductsData.products.removeWhere((p) => p['id'] == id);
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
