import 'package:my_store/shared/product/domain/entities/price.dart';

class OrderLineItem {
  const OrderLineItem({
    required this.productId,
    required this.quantity,
    required this.purchasePrice,
  });

  factory OrderLineItem.fromJson(Map<String, dynamic> json) {
    return OrderLineItem(
      productId: json['product_id'] as String,
      quantity: json['quantity'] as int,
      purchasePrice: Price.fromJson(
        json['purchase_price'] as Map<String, dynamic>,
      ),
    );
  }

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

  factory Order.fromJson(Map<String, dynamic> json) {
    final lineItems = (json['line_items'] as List<dynamic>?)?.map((e) {
      return OrderLineItem.fromJson(e as Map<String, dynamic>);
    }).toList();
    return Order(
      id: json['id'] as String,
      placedAt: DateTime.parse(json['placed_at'] as String),
      lineItems: lineItems ?? [],
    );
  }

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
