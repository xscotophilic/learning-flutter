import 'package:my_store/data/models/cart.dart';
import 'package:my_store/data/models/price.dart';

class Total {
  const Total({
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.currency,
  });

  factory Total.calculate(List<(CartItem, Price)> items) {
    if (items.isEmpty) {
      return const Total(subtotal: 0, discount: 0, total: 0, currency: '');
    }

    double subtotal = 0;
    double discount = 0;
    double totalAmount = 0;
    String? currency;

    for (final (cartItem, price) in items) {
      if (currency == null) {
        currency = price.currency;
      } else if (currency != price.currency) {
        currency = 'invalid';
      }

      subtotal += cartItem.calculateSubtotal(price);
      discount += cartItem.calculateDiscount(price);
      totalAmount += cartItem.calculateTotal(price);
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
