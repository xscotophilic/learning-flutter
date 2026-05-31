import 'package:my_store/shared/cart/domain/entities/cart.dart';

class CartPayload<T> {
  const CartPayload({required this.cart});

  factory CartPayload.fromJson(Map<String, dynamic> json) {
    return CartPayload<T>(
      cart: Cart<T>.fromJson(json['cart'] as Map<String, dynamic>),
    );
  }

  final Cart<T> cart;
}
