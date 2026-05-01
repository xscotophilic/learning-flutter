import 'package:my_store/data/models/price.dart';
import 'package:my_store/data/models/total.dart';

class CartItem {
  const CartItem({required this.productId, required this.quantity});

  final String productId;
  final int quantity;

  double calculateSubtotal(Price price) => price.amount * quantity;

  double calculateDiscount(Price price) {
    final discountPercent = price.discountPercent ?? 0;
    if (discountPercent > 0) {
      return (price.amount * discountPercent / 100) * quantity;
    }
    return 0;
  }

  double calculateTotal(Price price) {
    return calculateSubtotal(price) - calculateDiscount(price);
  }
}

class Cart {
  const Cart({
    required this.id,
    required this.ownerId,
    required this.createdAt,
    required this.items,
    required this.total,
  });

  final String id;
  final String ownerId;
  final DateTime createdAt;
  final List<CartItem> items;
  final Total total;
}
