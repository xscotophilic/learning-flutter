import 'package:my_store/shared/cart/domain/entities/cart.dart';

class Total {
  const Total({
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.currency,
  });

  factory Total.fromCartItems(List<CartItem> items) {
    if (items.isEmpty) {
      return const Total(subtotal: 0, discount: 0, total: 0, currency: '');
    }

    double subtotal = 0;
    double discount = 0;
    double totalAmount = 0;
    String? currency;

    for (final item in items) {
      final price = item.unitPrice;

      if (currency == null) {
        currency = price.currency;
      } else if (currency != price.currency) {
        currency = 'invalid';
      }

      subtotal += item.calculateSubtotal;
      discount += item.calculateTotalDiscount;
      totalAmount += item.calculateTotal;
    }

    return Total(
      subtotal: subtotal,
      discount: discount,
      total: totalAmount,
      currency: currency ?? 'invalid',
    );
  }

  final double subtotal;
  final double discount;
  final double total;
  final String currency;
}
