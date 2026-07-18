import 'package:my_store/features/product/domain/entities/price.dart';

class OrderLineItem {
  const OrderLineItem({
    required this.productId,
    required this.quantity,
    required this.purchasePrice,
  });

  final String productId;
  final int quantity;
  final Price purchasePrice;

  double get purchaseTotal {
    final discountedPrice = purchasePrice.calculateDiscountedPrice;
    return (discountedPrice ?? purchasePrice.amount) * quantity;
  }
}

class Order {
  const Order({
    required this.id,
    required this.placedAt,
    required this.lineItems,
  });

  final String id;
  final DateTime placedAt;
  final List<OrderLineItem> lineItems;

  String? get currency {
    String? c;
    for (final item in lineItems) {
      if (c == null) {
        c = item.purchasePrice.currency;
      } else if (c != item.purchasePrice.currency) {
        c = 'invalid';
      }
    }
    return c;
  }

  double get total {
    return lineItems.fold(0, (sum, item) => sum + item.purchaseTotal);
  }
}
