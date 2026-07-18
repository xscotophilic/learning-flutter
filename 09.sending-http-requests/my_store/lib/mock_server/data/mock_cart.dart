import 'package:my_store/core/extensions/iterable_extensions.dart';

class MockCartData {
  const MockCartData._();

  static final Map<String, Map<String, dynamic>> _carts = {};

  static Map<String, dynamic>? getActiveCart(String userId) {
    return {
      'cart': _carts.values.firstWhereOrNull(
        (c) => c['status'] == 'active' && c['owner_id'] == userId,
      ),
    };
  }

  static Map<String, dynamic> createCart({
    required String userId,
    required List<Map<String, dynamic>> items,
    required Map<String, dynamic> total,
  }) {
    final String cartId = 'cart-${DateTime.now().millisecondsSinceEpoch}';

    final cart = {
      'id': cartId,
      'owner_id': userId,
      'items': items,
      'total': total,
      'status': 'active',
      'created_at': DateTime.now().toIso8601String(),
    };

    _carts[cartId] = cart;

    return {'cart': _carts[cartId]};
  }

  static Map<String, dynamic>? getCartById(String cartId) {
    return {'cart': _carts[cartId]};
  }

  static void updateCartStatus(String cartId, String status) {
    final cart = _carts[cartId];
    if (cart == null) {
      throw Exception('cart not found');
    }

    _carts[cartId] = {...cart, 'status': status};
  }

  static Map<String, dynamic> updateCart({
    required String cartId,
    required List<Map<String, dynamic>> items,
    required Map<String, dynamic> total,
  }) {
    final cart = _carts[cartId];
    if (cart == null) {
      throw Exception('cart not found');
    }

    _carts[cartId] = {...cart, 'items': items, 'total': total};

    return {'cart': _carts[cartId]};
  }
}
