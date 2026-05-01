import 'package:my_store/data/models/price.dart';

class OrderLineItem {
  const OrderLineItem({
    required this.productId,
    required this.quantity,
    required this.purchasePrice,
  });

  final String productId;
  final int quantity;
  final Price purchasePrice;

  double get purchaseTotal => purchasePrice.amount * quantity;
}

class Order {
  const Order({
    required this.id,
    required this.placedAt,
    required this.lineItems,
    required this.currency,
  });

  final String id;
  final DateTime placedAt;
  final List<OrderLineItem> lineItems;
  final String currency;

  double get total {
    return lineItems.fold(0, (sum, item) => sum + item.purchaseTotal);
  }
}
