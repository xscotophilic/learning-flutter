class MockOrdersData {
  const MockOrdersData._();

  static final Map<String, Map<String, dynamic>> _orders = {};

  static Map<String, dynamic> createOrder({
    required List<Map<String, dynamic>> items,
  }) {
    final String orderId = 'order-${DateTime.now().millisecondsSinceEpoch}';

    final order = {
      'id': orderId,
      'line_items': items,
      'placed_at': DateTime.now().toIso8601String(),
    };

    _orders[orderId] = order;

    return {'order': order};
  }

  static Map<String, dynamic>? getOrders() {
    return {'orders': _orders.values.toList()};
  }
}
